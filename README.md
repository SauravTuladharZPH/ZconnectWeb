# Zconnect Web Automation

For using this repo, use the following command.

Git Clone:
git clone https://github.com/SauravTuladharZPH/ZconnectWeb.git

Before running the tests, make sure you have the following installed:

1. **Python 3.x**: You need Python to run the automation scripts.
2. **Robot Framework**: The core framework used for test automation.
3. **Other dependencies**: All required libraries are listed in `requirements.txt`.


Open the cloned repository in your IDE and enter the following command : <code> <b>pip install -r requirements.txt</b></code> </br></br>

**Execution:**</br>
To run the automation script use following command:</br></br>

<ul>
    <li>
        <code> <b>robot --outputdir ./results Tests/Login/LoginTest.robot</b></code> </br>
            This command will run the login test and store the output in results folder</br></br>
    </li>
</ul>

<ul>
    <li>
       <code> <b>robot --outputdir ./results .</b></code></br>
            This command will execute all the tests availale in the project </br></br>
    </li>
</ul>

<b>Project structure</b>
<li>workflows: This is the configuration file for GitHub Actions, which automates the process of running tests, such as continuous integration (CI). This file typically includes steps like setting up Python, installing dependencies, and executing tests on every push or pull request.</li>
<li>The Pages/ directory contains the Page Objects, which represent the different pages or components of the application.</li>
<li>Test cases in the Tests/ directory use the Page Object Model to interact with the page objects, encapsulating all the UI interactions in reusable keywords.</li>
<li>Helper scripts (in the Helper/ folder) provide common actions, utilities, and custom functions.</li>
<li>Resources/ holds any external data used for tests, such as Excel files for data-driven testing.</li>
<li>requirements.txt specifies the dependencies for the project, while gitignore helps to manage version control by excluding irrelevant files.</li>
