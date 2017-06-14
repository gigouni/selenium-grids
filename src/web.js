"use strict";

const CONSTANTS = require('./constants');
let webdriver = require('selenium-webdriver');
let By = require('selenium-webdriver').By;
let until = require('selenium-webdriver').until;
let test = require('selenium-webdriver/testing');

test.describe('Search my website on Google', () => {
    var driver;

    test.it('should redirect to my website with CHROME', () => {
        driver = new webdriver.Builder().withCapabilities(webdriver.Capabilities.chrome()).build()
        driver.get('http://google.com');
        driver.wait(until.titleIs('Google'));
        driver.wait(until.elementLocated(By.name('q'))).sendKeys('nicolas gigou');
        driver.findElement(By.name('btnG')).click();
        driver.wait(until.titleIs('nicolas gigou - Recherche Google'));
        driver.wait(until.elementLocated(By.tagName('h3.r a'))).click();
        driver.wait(until.titleIs('Nicolas GIGOU'));
        driver.quit();
    });
});