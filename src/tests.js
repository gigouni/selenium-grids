"use strict";

const CONSTANTS = require('./constants');
let webdriver = require('selenium-webdriver');
let test = require('selenium-webdriver/testing');


// ------------------------------------------------------------- //
//                      Remote testing                           //
// ------------------------------------------------------------- //
describe('Work with REMOTE URL', () => {

    // Capabilities
    let android_capabilities = new webdriver.Capabilities()
        .set('browserName', 'Chrome')
        .set('platformName', 'Android')
        .set('deviceName', 'emulator-5554');

    // Test
    test.it('should redirect to Google with CHROME', (done) => {
        
        let driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(webdriver.Capabilities.chrome())
            .build();

        driver.get(CONSTANTS.GOOGLE_URL);
        driver.wait(webdriver.until.titleIs(CONSTANTS.GOOGLE_TITLE));

        driver.quit();
        done();
    });

    test.it('should redirect to Google with FIREFOX', (done) => {

        let driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(webdriver.Capabilities.firefox())
            .build();

        driver.get(CONSTANTS.GOOGLE_URL);
        driver.wait(webdriver.until.titleIs(CONSTANTS.GOOGLE_TITLE));

        // driver.quit() returns an error for Firefox since FF > 46
        // WebDriverError: quit
        // driver.quit();

        // If you use driver.close(), the Firefox slot won't be free unless you wait 30 seconds. But why... ? 
        driver.close();
        done();
    });

    test.it('should redirect to Google', (done) => {

        let driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(android_capabilities)
            .build();

        driver.get(CONSTANTS.GOOGLE_URL);
        driver.wait(webdriver.until.titleIs(CONSTANTS.GOOGLE_TITLE));

        driver.quit();
        done();
    });
});