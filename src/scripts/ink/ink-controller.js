/**
 * @file ink-controller.js
 * @description Manages the Ink narrative system.
 */
import { story, _runtime } from "../main.js";
import DebugMode from "../system/debug-mode.js";

let choiceText;
let choiceArr = [];
let saveState;

/**
 * Class InkController manages the Ink JSON data.
 * @class InkController
 */
export class InkController 
{

	static paragraphText;

	constructor() 
	{
		this.className = 'InkController';
	}

	/**
	 * This is the main function called every time the story changes. It does a few things:
	 * Destroys all the old content and choices.
	 * Continues over all the lines of text, then displays all the choices.
	 * If there are no choices, the story is finished.
	 */
	static continueStory() 
	{
		this.paragraphText.text = "";

		// Fetch the story data from the ink-story.json
		while (story.canContinue) 
		{
			const text = story.Continue();  // Generate the next paragraph line.
			this.getParagraphText();        // Get the paragraph text instance.
			this.#getStoryTags();	        // Get the current story tags. 

			if (text.trim() !== "") 
			{
				this.paragraphText.text += text + '\n';  // Append text with a new line.
				DebugMode.printLog(`Print text`, text);  // Print log.
			}

			if (!story.canContinue) 
			{
				this.getStoryChoices();
			}
		}
	}

	static getParagraphText() 
	{
		const layer = 0;
		const posX = 100;
		const posY = 20;
		// Set the paragraph text game object.
		this.paragraphText = _runtime.objects.Paragraph.getFirstInstance(layer, posX, posY);
	}

	static getStoryChoices() 
	{
		const x     = 344
		const y     = 32;
		const vDist = 30;

		if (story.currentChoices.length > 0) 
		{
			for (let i = 0; i < story.currentChoices.length; ++i) 
			{
				choiceArr = story.currentChoices[i];

				// Get 'ChoiceText' instance.
				choiceText = _runtime.objects.ChoiceText.createInstance('Choices', x, y + vDist * i);
				choiceText.text = choiceArr.text;
				choiceText.instVars['id'] = i;

				console.log(choiceArr.text);
			}
		}
	}

	static chooseStoryPath(goto) 
	{
		// Let's select the current location in the INK story file.
		if (goto !== undefined) 
		{
			story.ChoosePathString(goto);
		}
		this.getParagraphText();  	// Get the Dialogue Text object.
		this.clearParagraphText(); // Clear paragraph text.
		this.clearChoiceArray();   // Clear choices array.
		this.continueStory(); 		// Continue the story.
	}

	/** 
	 * Let's clear the current paragraph text before displaying a new paragraph. 
	 */
	static clearParagraphText = () => this.paragraphText.text = "";


	static clearChoiceArray() 
	{
		for (const inst of _runtime.objects.ChoiceText.instances()) 
		{
			inst.destroy();
		}
		choiceArr = [];
	}

	/**
	 * Get the value of variables located inside the Ink JSON file (ink-data.json)
	 * 
	 * @param {string} txt - String value to search for.
	 * @returns {string}
	 */
	static getVariable(txt) 
	{
		console.log(`Ink ${txt} state`, story.variablesState[txt]);

		return story.variablesState[txt];
	}

	/**
	 * Set the value of variables located inside the Ink JSON file (ink-data.json)
	 * 
	 * @param {string} txt
	 * @param {string} newValue
	 */
	static setVariable(txt, newValue) 
	{
		story.variablesState[txt] = newValue;
	}

	/**
	 * Save the Ink story current state.
	 */
	static saveStoryState = () => saveState = story.state.ToJson();

	/**
	 * Load the stored Ink story state.
	 */
	static loadStoredState() 
	{
		if (saveState !== undefined) 
		{
			story.state.LoadJson(saveState);
		}
		// We should load the path as well.
		const path = '';
		this.chooseStoryPath(path);
	}

	/**
	 * Let' get all the tags located inside the current paragraph.
	 */
	static #getStoryTags() 
	{
		const curTags = story.currentTags;

		for (let i = 0; i < curTags.length; i++) 
		{
			const storyTag = curTags[i];
			switch (storyTag) {
				case 'HELLO_WORLD':
					DebugMode.printLog(`hello, world`);
					break;

				case 'SHOW_ACTOR':
					const actorLeft  = _runtime.objects.ActorLeft.getFirstInstance();
					const actorRight = _runtime.objects.ActorRight.getFirstInstance();
					// Show the actors...
					actorLeft.isVisible  = true;
					actorRight.isVisible = true;
					break;
			}
		}
	}

	/**
	 * Construct JS Functions can be called directly from within the Ink story.
	 */
	static setExternalFunctions() {
		story.BindExternalFunction('PlayBGM', (id) => {
			// Play the current bgm by id.
			_runtime.callFunction('PlayBGM', [id])
		});
	}
}







