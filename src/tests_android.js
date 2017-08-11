"use strict";

const CONSTANTS = require('./constants');
const PATH = require('path');
let webdriver = require('selenium-webdriver');
let By = require('selenium-webdriver').By;
let until = require('selenium-webdriver').until;
let Capabilities = require('selenium-webdriver').Capabilities;
let test = require('selenium-webdriver/testing');


// ------------------------------------------------------------- //
//                      Remote testing                           //
// ------------------------------------------------------------- //
test.describe('Work with REMOTE URL', () => {

    test.it('should redirect to Google', (done) => {

        let android_capabilities = new Capabilities()
            .set('browserName', 'Chrome')
            .set('platform', 'ANDROID')
            .set('deviceName', 'emulator-5554')
            .set('platformName', 'ANDROID');

        let driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(android_capabilities)
            .build();

        driver.get("https://github.com");
        driver.quit();
        done();
    });
});