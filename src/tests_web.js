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

    test.it('should redirect to Google with CHROME', () => {
        driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(webdriver.Capabilities.chrome())
            .build();
        driver.get(CONSTANTS.GOOGLE_URL);
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_TITLE));
        driver.wait(until.elementLocated(By.name(CONSTANTS.GOOGLE_SEARCH_KEY))).sendKeys(CONSTANTS.GOOGLE_SEARCH_VALUE);
        let btn_search = driver.findElement(By.name(CONSTANTS.GOOGLE_SEARCH_BUTTON_NAME));
        btn_search.click();
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_SEARCH_TITLE));
        driver.wait(until.elementLocated(By.tagName(CONSTANTS.GOOGLE_RES_LINK))).click();
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_TITLE));
        driver.quit();
    });

    // console.log(`Do you want to use Marionette for FF < 47? ${process.env.MARIONETTE}`);

    test.it('should redirect to Google with FIREFOX', () => {
        driver = new webdriver.Builder()
            .usingServer(CONSTANTS.SELENIUM_HUB)
            .withCapabilities(webdriver.Capabilities.firefox())
            .build();
        driver.get(CONSTANTS.GOOGLE_URL);
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_TITLE));
        driver.wait(until.elementLocated(By.name(CONSTANTS.GOOGLE_SEARCH_KEY))).sendKeys(CONSTANTS.GOOGLE_SEARCH_VALUE);
        driver.findElement(By.name(CONSTANTS.GOOGLE_SEARCH_BUTTON_NAME)).click();
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_SEARCH_TITLE));
        driver.wait(until.elementLocated(By.tagName(CONSTANTS.GOOGLE_RES_LINK))).click();
        driver.wait(until.titleIs(CONSTANTS.GOOGLE_TITLE));
        driver.quit();
    });
});