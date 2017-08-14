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
describe('Work with REMOTE URL', () => {

    // Capabilities
    let android_capabilities = new Capabilities()
        .set('browserName', 'Chrome')
        .set('platform', 'ANDROID')
        .set('platformName', 'Android')
        .set('deviceName', 'emulator-5554');

    // Test
    test.it('should redirect to Github', (done) => {

        let driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(android_capabilities)
            .build();

        driver.get(CONSTANTS.GOOGLE_URL);
        done();
    });
});