Feature: Generate valid first, last name; adress; telephone

	Scenario Outline: Generate name, adress, telephone
		Given the input "<language>"
		And input "<number>"
		And "<misstake_percentage>"
		When the test_data_generator is run
		Then output lSength should be "<length>"
		

	Examples:
		| language | number | misstake_percentage | length           | 
		| en       | 2      | 0                   | 2                |
		| ru       | 1      | 1                   | 1                |

