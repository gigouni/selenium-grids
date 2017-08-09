"use strict";

const CONSTANTS = require('./constants');
const PATH = require('path');
let webdriver = require('selenium-webdriver');
let By = require('selenium-webdriver').By;
let until = require('selenium-webdriver').until;
let test = require('selenium-webdriver/testing');

// ------------------------------------------------------------- //
//                      Remote testing                           //
// ------------------------------------------------------------- //
test.describe('Work with REMOTE URL', () => {

    let driver;

    test.it('should redirect to Google', () => {
        driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(webdriver.Capabilities.android())
            .build();
        driver.get(CONSTANTS.GOOGLE_URL);
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_TITLE));
        driver.quit();
    });
});