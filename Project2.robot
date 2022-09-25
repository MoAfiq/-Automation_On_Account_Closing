*** Settings ***
Library	SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']

*** Keywords ***
Login To Deriv
	Open Browser	https://app.deriv.com/	Chrome
	Maximize Browser Window
    Wait Until Page Contains Element     //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    dt_login_button    
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']     putyouremailhere@besquare.com.my
    Input Text    //input[@type='password']    @putyourpasswordhere
    Click Element    //button[@type='submit']
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Sleep    5
    Click Element    //div[@id='dt_core_account-info_acc-info'] 
    Click Element    //li[@id='dt_core_account-switcher_demo-tab']
    Click Element    //div[@class='dc-content-expander__content'] 

*** Test Cases ***
Login To Account
    Login To Deriv
Navigate To Close Account Page
    Wait Until Page Contains Element    //a[@class="account-settings-toggle"]    30
    Sleep    10
    Click Element    //a[@class="account-settings-toggle"]
    Sleep    3
    Click Element    //a[@id="dc_close-your-account_link"]
Page Should Contain Closing Account Information - Security And Privacy Policy, Close My Account Button And Cancel Button
    Page Should Contain Element    //.//p[text()='Are you sure?']
    Page Should Contain Element    //.//p[text()='If you close your account:']
    Page Should Contain Element    //.//p[text()='Before closing your account:']
    Page Should Contain Element    //.//p[text()='We shall delete your personal information as soon as our legal obligations are met, as mentioned in the section on Data Retention in our ']
    Page Should Contain Element    //button[@class="dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel"]
    Page Should Contain Element    //button[@class="dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account"]
Clicking Security And Privacy Policy Will Lead To PDF File
    Sleep    2
    Click Element    //a[@href="https://deriv.com/tnc/security-and-privacy.pdf"]
    Sleep    5
    Switch Window     
Clicking Close My Account Will Lead To Closing Account Reasons Page
    Click Element    //button[@class="dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account"]
    Sleep    2
Check Whether Users Have All Checkboxes And Textfield For Closing Account Reasons
    Page Should Contain Element    //.//span[text()='I have other financial priorities.']
    Page Should Contain Element    //.//span[text()='I want to stop myself from trading.']
    Page Should Contain Element    //.//span[text()='I’m no longer interested in trading.']
    Page Should Contain Element    //.//span[text()='I prefer another trading website.']
    Page Should Contain Element    //.//span[text()='The platforms aren’t user-friendly.']
    Page Should Contain Element    //.//span[text()='Making deposits and withdrawals is difficult.']
    Page Should Contain Element    //.//span[text()='The platforms lack key features or functionality.']
    Page Should Contain Element    //.//span[text()='Customer service was unsatisfactory.']
    Page Should Contain Element    //.//span[text()='I’m closing my account for other reasons.']
    Page Should Contain Element    //textarea[@name="other_trading_platforms"]
    Page Should Contain Element    //textarea[@name="do_to_improve"]
Continue Button Should Be Unavailable, Back Button Is Available If None Input Were Given Yet
    Page Should Not Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large" and disabled]
    Page Should Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large"]
User Can Click Maximum 3 Closing Account Reasons Checkboxes
    Click Element    //.//span[text()='I have other financial priorities.']
    Click Element    //.//span[text()='I want to stop myself from trading.']
    Click Element    //.//span[text()='I’m no longer interested in trading.']
    Page Should Contain Element    //span[@class="dc-checkbox__box dc-checkbox__box--disabled"]
User Will Get Error Message If No Reasons Were Checked After Have Done It Before
    Click Element    //.//span[text()='I have other financial priorities.']
    Click Element    //.//span[text()='I want to stop myself from trading.']
    Click Element    //.//span[text()='I’m no longer interested in trading.']
    Page Should Contain Element   //.//p[text()="Please select at least one reason"] 
    Click Element    //.//span[text()='I have other financial priorities.']
Negative Testing - First Textfield - With Correct Errors Message
    Click Element    //textarea[@name="other_trading_platforms"]
    Input Text    //textarea[@name="other_trading_platforms"]    APItoken%&
    Page Should Contain Element    //.//p[text()="Must be numbers, letters, and special characters . , ' -"]
    Press Keys    //textarea[@name="other_trading_platforms"]    CTRL+a+BACKSPACE
    Input Text    //textarea[@name="other_trading_platforms"]    Äöü
    Page Should Contain Element    //.//p[text()="Must be numbers, letters, and special characters . , ' -"]
    Press Keys    //textarea[@name="other_trading_platforms"]    CTRL+a+BACKSPACE
    Input Text    //textarea[@name="other_trading_platforms"]    我不知道
    Page Should Contain Element    //.//p[text()="Must be numbers, letters, and special characters . , ' -"]
    Press Keys    //textarea[@name="other_trading_platforms"]    CTRL+a+BACKSPACE
Positive Testing - First Textfield
    Sleep    3
    Page Should Contain Element    //span[@class="dc-checkbox__box dc-checkbox__box--active"]
    Input Text    //textarea[@name="other_trading_platforms"]    Random Words That Can Be Typed In Only 110 Characters Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ip
    Page Should Contain Element    //.//p[text()="Remaining characters: 0"]
    Page Should Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
Check That Second Textfield Cannot Be Typed If The First Textfield Already Use All Remaining Characters
    Click Element    //textarea[@name="do_to_improve"]
    Input Text    //textarea[@name="do_to_improve"]    Trying to type in second textfield here. Any input...
    Textarea Value Should Be    //textarea[@name="do_to_improve"]    ${EMPTY}    
Negative Testing - Second Textfield - With Correct Errors Message
    Click Element    //textarea[@name="other_trading_platforms"]
    Press Keys    //textarea[@name="other_trading_platforms"]    CTRL+a+BACKSPACE
    Click Element    //textarea[@name="do_to_improve"]
    Input Text    //textarea[@name="do_to_improve"]    APItoken%&
    Page Should Contain Element    //.//p[text()="Must be numbers, letters, and special characters . , ' -"]
    Press Keys    //textarea[@name="do_to_improve"]    CTRL+a+BACKSPACE
    Input Text    //textarea[@name="do_to_improve"]    Äöü
    Page Should Contain Element    //.//p[text()="Must be numbers, letters, and special characters . , ' -"]
    Press Keys    //textarea[@name="do_to_improve"]    CTRL+a+BACKSPACE
    Input Text    //textarea[@name="do_to_improve"]    我不知道
    Page Should Contain Element    //.//p[text()="Must be numbers, letters, and special characters . , ' -"]
    Press Keys    //textarea[@name="do_to_improve"]    CTRL+a+BACKSPACE
Positive Testing - Second Textfield
    Sleep    3
    Page Should Contain Element    //span[@class="dc-checkbox__box dc-checkbox__box--active"]
    Input Text    //textarea[@name="do_to_improve"]    Random Words That Can Be Typed In Only 110 Characters Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ip
    Page Should Contain Element    //.//p[text()="Remaining characters: 0"]
    Page Should Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
Check That First Textfield Cannot Be Typed If The Second Textfield Already Use All Remaining Characters
    Click Element    //textarea[@name="other_trading_platforms"]
    Input Text    //textarea[@name="other_trading_platforms"]    Trying to type in second textfield here. Any input...
    Textarea Value Should Be    //textarea[@name="other_trading_platforms"]    ${EMPTY}    
Creating A Valid Closing Account Application - With 3 Reasons And Trading Platform And Do-To-Improve
    Click Element    //.//span[text()='I prefer another trading website.']
    Click Element    //.//span[text()='The platforms lack key features or functionality.']
    Input Text    //textarea[@name="other_trading_platforms"]    DMarket
    Input Text    //textarea[@name="do_to_improve"]    Do-To-Improves...
Validating That Close Your Account Popup Will Appear
    Click Element     //div[@class="dc-form-submit-button dc-form-submit-button--relative"]/button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Sleep    5
    Page Should Contain Element    //div[@class="dc-modal__container dc-modal__container_closing-account-reasons dc-modal__container--enter-done"]
    Page Should Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large"]
    Page Should Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
Pressing Go Back Button Will Go Back To Closing Account Reasons Page
    Sleep    3
    Click Element    //div[@class="dc-form-submit-button account-closure-warning-modal__close-account-button dc-form-submit-button--relative"]/button[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large"]
    Page Should Not Contain Element    //div[@class="dc-modal__container dc-modal__container_closing-account-reasons dc-modal__container--enter-done"]
Pressing Close Account Will Proceed To Close The Account
    Sleep    5
    Click Element     //div[@class="dc-form-submit-button dc-form-submit-button--relative"]/button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Click Element     //div[@class="dc-form-submit-button account-closure-warning-modal__close-account-button dc-form-submit-button--relative"]/button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Sleep    5
    Close Browser
