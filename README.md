# Capture Neorg GTD

This is a workflow for capturing a GTD into neorg without opening Nvim for those fleeting "yeah i'd better get around to that" moments.

## Usage:

	gtd <task_name> -> waiting_for -> contexts

The `waiting_for` and `contexts` inputs are optional.
If you press enter without typing anything in, those sections will not be included in the GTD.

## Configuration:

Can either write to today's journal entry, or a specified file by providing a target_file variable (click the [x] in the workflow view)

	- neorg_workspace (absolute path) (REQUIRED):
		path to your neorg workspace
	
	- target_file (relative to neorg workspace) (OPTIONAL):
		- if empty the target will be "/journal/<Y>/<m>/<d>.norg"
		- if value provided, the GTD will be written there.
			If the file doesn't exist, it will be created.
