package example

import (
	"encoding/json"
	"path"

	"tool/exec"
	"tool/os"
)

command: simulate: {
	_env: os.Environ & {}

	validate: exec.Run & {
		env: _env & {
			// TODO: should rely on os.Getwd instead of PWD which is
			// SHELL-dependent.
			CLAUDE_PROJECT_DIR: _env.PWD
		}
		_input: #postEditToolUseInput
		_input: input & {
			#dir: env.PWD
		}
		stdin: json.Marshal(_input)
		cmd: ["./.claude/validate-github-actions.sh"]
	}
}

input: {
	#dir!:           string
	session_id:      "31be24c1-812e-4e0c-a23e-df42f48844de"
	transcript_path: "/home/myitcv/.claude/projects/-home-myitcv-tmp-claude-go-example/31be24c1-812e-4e0c-a23e-df42f48844de.jsonl"
	cwd:             #dir
	permission_mode: "default"
	hook_event_name: "PostToolUse"
	tool_name:       "Edit"
	tool_input: {
		file_path: path.Join([#dir, ".github/workflows/ci.yml"])
		old_string: "on:\n  push:\n    branches: [ main ]\n\nsomething: else\n\njobs:"
		new_string: "on:\n  push:\n    branches: [ main ]\n\njobs:"
	}
	tool_response: {
		filePath: path.Join([#dir, ".github/workflows/ci.yml"])
		oldString:    "on:\n  push:\n    branches: [ main ]\n\nsomething: else\n\njobs:"
		newString:    "on:\n  push:\n    branches: [ main ]\n\njobs:"
		originalFile: "name: CI\n\non:\n  push:\n    branches: [ main ]\n\nsomething: else\n\njobs:\n  ci:\n    name: CI\n    runs-on: ubuntu-latest\n\n    steps:\n    - name: Check out code\n      uses: actions/checkout@v4\n\n    - name: Set up Go\n      uses: actions/setup-go@v5\n      with:\n        go-version: 1.25.x\n\n    - name: Cache Go modules\n      uses: actions/cache@v4\n      with:\n        path: ~/go/pkg/mod\n        key: ${{ runner.os }}-go-${{ hashFiles('**/go.sum') }}\n        restore-keys: |\n          ${{ runner.os }}-go-\n\n    - name: Run vet\n      run: go vet ./...\n\n    - name: Run tests\n      run: go test -v ./...\n"
		structuredPatch: [
			{
				oldStart: 4
				oldLines: 8
				newStart: 4
				newLines: 6
				lines: [
					"   push:",
					"     branches: [ main ]",
					" ",
					"-something: else",
					"-",
					" jobs:",
					"   ci:",
					"     name: CI",
				]
			},
		]
		userModified: false
		replaceAll:   false
	}
}
