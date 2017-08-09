/**
 * --------------------------------------------------------------------------------------------------------------
 * Constants.
 *
 * @since 0.0.1.
 * @author Nicolas GIGOU.
 * @description A config file to pool all the constants into a single file. Improve the maintainability.
 *
 * *-*-*-*-*-*-*
 * How to use it
 * *-*-*-*-*-*-*
 *
 * <code>
 *      [...]
 *      const CONSTANTS = require('../constants');
 *      [...]
 *      console.log(`My constant: ${CONSTANTS.LINK_ID}`);
 * </code>
 * --------------------------------------------------------------------------------------------------------------
 */
// ------------------------------------------------------------- //
//                       Hub and nodes                           //
// ------------------------------------------------------------- //
const _SELENIUM_HOST = 'http://172.17.0.2';
const _SELENIUM_PORT = 4444;
const _PATH_TO_HUB = '/wd/hub';

const _SELENIUM_HUB = `${_SELENIUM_HOST}:${_SELENIUM_PORT}${_PATH_TO_HUB}`;


// ------------------------------------------------------------- //
//                          Google                               //
// ------------------------------------------------------------- //
const _GOOGLE_URL = 'http://google.com';
const _GOOGLE_TITLE = 'Google';

module.exports = {

    SELENIUM_HUB: _SELENIUM_HUB,

    GOOGLE_URL: _GOOGLE_URL,
    GOOGLE_TITLE: _GOOGLE_TITLE
}