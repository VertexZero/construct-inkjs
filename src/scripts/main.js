/* main.js */
import { Story } from "./ink/lib/ink-es6.js";
import { InkController } from "./ink/ink-controller.js";

let story;
let _runtime;

runOnStartup(async runtime => {
	// There's nothing else that can be done before the runtime starts up, so wait until the "beforeprojectstart" event fires to finish the
	// rest of initialisation. This runs just before 'On start of layout' on the first layout.
	runtime.addEventListener("beforeprojectstart", () => OnBeforeProjectStart(runtime));
});

/** 
 *	Code to run just before 'On start of layout' on the first layout. 
 * Loading has finished and initial instances are created and available to use here. 
 * 
 * @param {Object} runtime - Construct 3 runtime object.
 */
async function OnBeforeProjectStart(runtime) 
{
	// This runs just as the loading screen appears, before the runtime has finished loading.
	_runtime = runtime;
	// Let's load all JSON data files first.
	fetchDataFromJSON(runtime);

	// Just before the project starts, add a "beforelayoutstart" event handler to set up the initial state of the layout. This is also
	// called on startup, and will be called again if the layout restarts, which can happen after the Player dies.
	runtime.layout.addEventListener("beforelayoutstart", () => OnBeforeLayoutStart(runtime));
	// Attach the tick event to run the game logic over time.
	runtime.addEventListener("tick", () => update(runtime));
}

/** This is called every time the layout starts, just before 'On start of layout'. Set up the initial state of the layout. */
function OnBeforeLayoutStart(runtime) 
{
}

/** 
 * Game Update
 * 
 * @param {Object} runtime - Construct 3 runtime object.
 */
function update(runtime) 
{
	// The tick event runs every frame. 
	// The game needs to be advanced by the amount of time in delta-time, also known as dt.
	const dt = runtime.dt;
}

/** 
 * Fetch the ink json file from the Files folder.
 * 
 * @param {Object} runtime - Construct 3 runtime object. 
 */
async function fetchDataFromJSON(runtime) 
{
	// Get the correct URL to fetch.
	const jsonUrl = await runtime.assets.getProjectFileUrl('ink-story.json');

	// Now let's fetch the JSON file URL.
	const response    = await fetch(jsonUrl);
	const fetchedJson = await response.text();

	story = new Story(fetchedJson);

	InkController.setExternalFunctions();
}

export { story, _runtime };













