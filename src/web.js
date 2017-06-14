"use strict";

const CONSTANTS = require('./constants');
let webdriver = require('selenium-webdriver');
let By = require('selenium-webdriver').By;
let until = require('selenium-webdriver').until;
let test = require('selenium-webdriver/testing');

test.describe('Search my website on Google', function() {
    this.timeout(15000);
    var driver;

    test.it('should redirect to my website with CHROME', function() {
        driver = new webdriver.Builder().withCapabilities(webdriver.Capabilities.chrome()).build()
        driver.get('http://google.com');
        driver.wait(until.titleIs('Google'));
        driver.findElement(By.name('q')).sendKeys('nicolas gigou');
        driver.findElement(By.name('btnG')).click();
        driver.wait(until.titleIs('nicolas gigou - Recherche Google'));
        driver.findElement(By.tagName('h3.r a')).click();
        driver.wait(until.titleIs('Nicolas GIGOU'));
        driver.quit();
    });
});