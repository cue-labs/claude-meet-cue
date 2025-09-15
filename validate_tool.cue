package example

import (

	"tool/os"
	"tool/file"
	"encoding/json"
	"strings"
	"path"

	"tool/exec"
)

_os: string @tag(os, var=os)

command: validate: {
	env: os.Getenv & {
		CLAUDE_PROJECT_DIR: string
	}

	read: file.Read & {
		$after:   env
		filename: "/dev/stdin"
		contents: string

		hookInput: {#hookInput, ...}
		hookInput: json.Unmarshal(contents)
	}

	if (read.hookInput & #postEditToolUseInput) != _|_ {
		let filepath = path.ToSlash(read.hookInput.tool_input.file_path, _os)
		let filename = path.Base(filepath, _os)
		let dir = path.Rel(env.CLAUDE_PROJECT_DIR, path.Dir(filepath), _os)

		if strings.HasSuffix(filename, ".yml") && dir == ".github/workflows" {
			validate: exec.Run & {
				cmd: ["cue", "vet", "-c", "-d=#Workflow", "cue.dev/x/githubactions@latest", filepath]
			}
		}
	}
}
