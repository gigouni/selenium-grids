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
const _FIREFOX_HOST = 'http://172.17.0.4';
const _CHROME_HOST = 'http://172.17.0.3';
const _ANDROID_HOST = 'http://10.0.2.15';
const _ANDROID_PORT = 5555;
const _PORT_BASE = 5555;
const _SELENIUM_PORT = 4444;
const _PATH_TO_HUB = '/wd/hub';

const _FIREFOX_NODE = `${_FIREFOX_HOST}:${_PORT_BASE}${_PATH_TO_HUB}`;
const _CHROME_NODE = `${_CHROME_HOST}:${_PORT_BASE}${_PATH_TO_HUB}`;
const _ANDROID_NODE = `${_ANDROID_HOST}:${_ANDROID_PORT}${_PATH_TO_HUB}`;

const _SELENIUM_HUB = `${_SELENIUM_HOST}:${_SELENIUM_PORT}${_PATH_TO_HUB}`;


// ------------------------------------------------------------- //
//                          Google                               //
// ------------------------------------------------------------- //
const _GOOGLE_URL = 'http://google.com';
const _GOOGLE_TITLE = 'Google';
const _GOOGLE_SEARCH_BUTTON_ID = 'btnG';
const _GOOGLE_SEARCH_KEY = 'q';
const _GOOGLE_SEARCH_VALUE = 'google';
const _GOOGLE_SEARCH_TITLE = _GOOGLE_SEARCH_VALUE + ' - Recherche Google';
const _GOOGLE_RES_LINK = 'h3.r a';

module.exports = {

    FIREFOX_NODE: _FIREFOX_NODE,
    CHROME_NODE: _CHROME_NODE,
    ANDROID_NODE: _ANDROID_NODE,
    SELENIUM_HUB: _SELENIUM_HUB,

    GOOGLE_URL: _GOOGLE_URL,
    GOOGLE_TITLE: _GOOGLE_TITLE,
    GOOGLE_SEARCH_BUTTON_ID: _GOOGLE_SEARCH_BUTTON_ID,
    GOOGLE_SEARCH_KEY: _GOOGLE_SEARCH_KEY,
    GOOGLE_SEARCH_VALUE: _GOOGLE_SEARCH_VALUE,
    GOOGLE_SEARCH_TITLE: _GOOGLE_SEARCH_TITLE,
    GOOGLE_RES_LINK: _GOOGLE_RES_LINK
}