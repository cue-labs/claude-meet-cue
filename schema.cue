package example

// #hookInput defines the base schema of all hook inputs. Per the CUE that
// appears at https://docs.anthropic.com/en/docs/claude-code/hooks#hook-input
#hookInput: {
	session_id!:      string
	transcript_path!: string
	cwd!:             string
	permission_mode?: string
	hook_event_name!: string
}

// #toolBase is the base set of fields for a hook tool.
#toolBase: {
	#hookInput

	tool_name!:     string
	tool_input?:    _
	tool_response?: _
}

// #preToolUseInput is the base schema for PostToolUse hooks.
#preToolUseInput: {
	#toolBase

	hook_event_name!: "PreToolUse"
}

// #editTool is the schema for the Edit tool
#editTool: {
	#toolBase

	tool_name!: "Edit"
	tool_input?: {
		file_path!:  string
		old_string!: string
		new_string!: string
	}
	tool_response?: {
		filePath!:     string
		oldString!:    string
		newString!:    string
		originalFile!: string
		structuredPatch: [...]
		replaceAll?:   bool
		userModified?: bool
	}
}

// #postToolUseInput is the base schema for PostToolUse hooks.
#postToolUseInput: {
	#toolBase

	hook_event_name!: "PostToolUse"
	tool_response!:   _
}

#preEditToolUseInput: {
	#editTool
	#preToolUseInput
}

#postEditToolUseInput: {
	#editTool
	#postToolUseInput
}
