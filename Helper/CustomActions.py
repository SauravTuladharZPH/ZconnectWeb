from selenium.webdriver.common.action_chains import ActionChains
from SeleniumLibrary import SeleniumLibrary
from robot.api.deco import keyword


class CustomActions:
    def __init__(self):
        # Use SeleniumLibrary as a component
        self.selib = SeleniumLibrary()

    @keyword(name="Click Element With Actions")
    def click_element_with_actions(self, locator):
        """
        Click an element using Selenium's ActionChains.

        :param locator: The locator of the element (XPath, CSS, etc.).
        Example usage in Robot Framework:
        | Click Element With Actions | xpath=//button[@id='submit'] |
        """
        # Ensure a valid browser session is open
        driver = self.selib.driver
        if not driver:
            raise RuntimeError("No active browser session detected.")
        else:
            print(f"Browser session is active: {driver}")

        # Find the element using SeleniumLibrary's find_element
        try:
            element = self.selib.find_element(locator)
            print(f"Element found: Displayed={element.is_displayed()}, Enabled={element.is_enabled()}")
        except Exception as e:
            raise RuntimeError(f"Failed to locate element with locator '{locator}'. Error: {e}")

        # Ensure the element is interactable
        if not (element.is_displayed() and element.is_enabled()):
            raise RuntimeError(f"Element located by '{locator}' is not interactable. Please check its state.")

        # Perform the action using ActionChains
        try:
            actions = ActionChains(driver)
            actions.move_to_element(element).click().perform()
            print(f"Successfully clicked on the element located by '{locator}'.")
        except Exception as e:
            raise RuntimeError(f"Failed to click on the element located by '{locator}' using ActionChains. Error: {e}")

    @keyword(name="Verify Browser Session Is Active")
    def verify_browser_session(self):
        """
        Verifies if there is an active browser session.
        """
        driver = self.selib.driver
        if not driver:
            print("DEBUG: No browser driver found in SeleniumLibrary.")
            raise RuntimeError(
                "No active browser session detected. Please ensure the browser is open using 'Open Browser'.")
        else:
            print(f"DEBUG: Browser session active. Driver: {driver}")

# Add this section to ensure libdoc can handle the library
if __name__ == "__main__":
    from robot.libdoc import libdoc
    libdoc(__file__, "CustomActions.html")

