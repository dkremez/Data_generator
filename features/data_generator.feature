Feature: Generate valid first, last name; adress; telephone

	Scenario Outline: Generate name, adress, telephone
		Given the input "<language>"
		And input "<number>"
		And "<misstake_percentage>"
		When the test_data_generator is run
		Then output name should be "<name>"
		And adress: "<address>"
		And  telephone: "<phone_number>"

	Examples:
		| language | number | misstake_percentage | name           | address  | phone_number |
		| en       | 1      | 0                   | "Jone Smith"   |"Smith"   |   "Smith"    |
		| ru       | 1      | 1                   | "Иванов Иван"  | address  | phone_number |

