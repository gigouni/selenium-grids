"use strict";

const CONSTANTS = require('../constants');
const PATH = require('path');
let webdriver = require('selenium-webdriver');
let By = require('selenium-webdriver').By;
let until = require('selenium-webdriver').until;
let test = require('selenium-webdriver/testing');


// ------------------------------------------------------------- //
//                      Remote testing                           //
// ------------------------------------------------------------- //
test.describe('Search Google on Google (Google-ception)', () => {
    var driver;

    test.it('should redirect to my website with CHROME', () => {
        driver = new webdriver.Builder().usingServer('http://172.17.0.1:5557/wd/hub').withCapabilities(webdriver.Capabilities.chrome()).build()
        driver.get('http://google.com');
        driver.wait(until.titleIs('Google'));
        driver.wait(until.elementLocated(By.name('q'))).sendKeys('google');
        driver.findElement(By.name('btnG')).click();
        driver.wait(until.titleIs('google - Recherche Google'));
        driver.wait(until.elementLocated(By.tagName('h3.r a'))).click();
        driver.wait(until.titleIs('Google'));
        driver.quit();
    });

    test.it('should redirect to my website with FIREFOX', () => {
        driver = new webdriver.Builder().usingServer('http://172.17.0.1:5555/wd/hub').withCapabilities(webdriver.Capabilities.firefox()).build()
        driver.get('http://google.com');
        driver.wait(until.titleIs('Google'));
        driver.wait(until.elementLocated(By.name('q'))).sendKeys('google');
        driver.findElement(By.name('btnG')).click();
        driver.wait(until.titleIs('google - Recherche Google'));
        driver.wait(until.elementLocated(By.tagName('h3.r a'))).click();
        driver.wait(until.titleIs('Google'));
        driver.quit();
    });

    test.it('should redirect to my website with EDGE', () => {
        driver = new webdriver.Builder().usingServer('http://172.17.0.1:5558/wd/hub').withCapabilities(webdriver.Capabilities.edge()).build()
        driver.get('http://google.com');
        driver.wait(until.titleIs('Google'));
        driver.wait(until.elementLocated(By.name('q'))).sendKeys('google');
        driver.findElement(By.name('btnG')).click();
        driver.wait(until.titleIs('google - Recherche Google'));
        driver.wait(until.elementLocated(By.tagName('h3.r a'))).click();
        driver.wait(until.titleIs('Google'));
        driver.quit();
    });
});

// ------------------------------------------------------------- //
//                      Local testing                            //
// ------------------------------------------------------------- //
test.describe('Work with local file', () => {
    var driver;

    test.it('should redirect to Google with CHROME', () => {
        driver = new webdriver.Builder().usingServer('http://172.17.0.1:5557/wd/hub').withCapabilities(webdriver.Capabilities.chrome()).build()
        driver.get('file://' + PATH.join(__dirname, 'index.html'));
        driver.wait(until.elementLocated(By.id('link'))).click();
        driver.wait(until.titleIs('Google'));
        driver.quit();
    });

    test.it('should redirect to Google with FIREFOX', () => {
        driver = new webdriver.Builder().usingServer('http://172.17.0.1:5555/wd/hub').withCapabilities(webdriver.Capabilities.firefox()).build()
        driver.get('file://' + PATH.join(__dirname, 'index.html'));
        driver.wait(until.elementLocated(By.id('link'))).click();
        driver.wait(until.titleIs('Google'));
        driver.quit();
    });

    test.it('should redirect to Google with EDGE', () => {
        driver = new webdriver.Builder().usingServer('http://172.17.0.1:5558/wd/hub').withCapabilities(webdriver.Capabilities.edge()).build()
        driver.get('file://' + PATH.join(__dirname, 'index.html'));
        driver.wait(until.elementLocated(By.id('link'))).click();
        driver.wait(until.titleIs('Google'));
        driver.quit();
    });
});