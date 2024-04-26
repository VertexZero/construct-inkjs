/**
 * @file debug-mode.js
 * @description Manages the console debug mode.
 */

/**
 * Class Manages the debug mode if enabled.
 * @class DebugMode
 */
export default class DebugMode 
{
	static enabled = true;   // On release, disable.

	static #style = {
		saphire: 'background: #161616; color: #0F52BA; font-family:Consolas; font-size: 10px',
		crimson: 'background: #161616; color: #DC143C; font-family:Consolas; font-size: 10px',
		emerald: 'background: #161616; color: #38B261; font-family:Consolas; font-size: 10px',
	};

	static printLog(message, ...arg) 
   {
		if (this.enabled) 
		{
			const arrow = arg.length === 0 ? '' : '=>';
			console.log(`%c ${message.padEnd(25)} ${arrow} ${arg}`, this.#style.emerald);
		}
	}
 
	static warn(message) 
   {
		if (this.enabled) 
      {
			console.log(`%c ${message.padEnd(25)}`, this.#style.crimson);
		}
	}

	static error(message, className, funcName) 
   {
		if (this.enabled) 
      {
			console.error(`
				Fatal Error: ERROR THROWN FROM ${className}.${funcName}!
				err: ${message}
			`);
		}
	}
}