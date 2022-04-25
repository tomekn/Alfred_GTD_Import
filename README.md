Capture Neorg GTD

This is a workflow for capturing a GTD into neorg without opening Nvim for those fleeting "yeah i'd better get around to that" moments.

USAGE:

	gtd <task_name> -> waiting_for -> contexts


CONFIGURATION:

	Can either write to today's journal entry, or a specified file by providing a target_file variable (click the [x] in the workflow view)

	- neorg_workspace (absolute path) (REQUIRED): path to your neorg workspace
	- target file (relative to neorg workspace) (OPTIONAL):
		- if empty the target will be "/journal/<Y>/<m>/<d>.norg"
		- if value provided, the GTD will be written there. if the file doesn't exist, it will be created.
