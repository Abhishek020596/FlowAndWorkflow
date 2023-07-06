public with sharing class JSON2Apex {
   
	public class BillAddr {
		public String Id {get;set;} 

		public BillAddr(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Id') {
							Id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'BillAddr consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CurrencyRef {
		public String value {get;set;} 
		public String name {get;set;} 

		public CurrencyRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CurrencyRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Customer Customer {get;set;} 
	public String time_Z {get;set;} // in json: time

	public JSON2Apex(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'Customer') {
						Customer = new Customer(parser);
					} else if (text == 'time') {
						time_Z = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Customer {
		public Boolean Taxable {get;set;} 
		public BillAddr BillAddr {get;set;} 
		public BillAddr ShipAddr {get;set;} 
		public Boolean Job {get;set;} 
		public Boolean BillWithParent {get;set;} 
		public Integer Balance {get;set;} 
		public Integer BalanceWithJobs {get;set;} 
		public CurrencyRef CurrencyRef {get;set;} 
		public String PreferredDeliveryMethod {get;set;} 
		public String domain {get;set;} 
		public Boolean sparse {get;set;} 
		public String Id {get;set;} 
		public String SyncToken {get;set;} 
		public MetaData MetaData {get;set;} 
		public String FullyQualifiedName {get;set;} 
		public String CompanyName {get;set;} 
		public String DisplayName {get;set;} 
		public String PrintOnCheckName {get;set;} 
		public Boolean Active {get;set;} 
		public DefaultTaxCodeRef DefaultTaxCodeRef {get;set;} 

		public Customer(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Taxable') {
							Taxable = parser.getBooleanValue();
						} else if (text == 'BillAddr') {
							BillAddr = new BillAddr(parser);
						} else if (text == 'ShipAddr') {
							ShipAddr = new BillAddr(parser);
						} else if (text == 'Job') {
							Job = parser.getBooleanValue();
						} else if (text == 'BillWithParent') {
							BillWithParent = parser.getBooleanValue();
						} else if (text == 'Balance') {
							Balance = parser.getIntegerValue();
						} else if (text == 'BalanceWithJobs') {
							BalanceWithJobs = parser.getIntegerValue();
						} else if (text == 'CurrencyRef') {
							CurrencyRef = new CurrencyRef(parser);
						} else if (text == 'PreferredDeliveryMethod') {
							PreferredDeliveryMethod = parser.getText();
						} else if (text == 'domain') {
							domain = parser.getText();
						} else if (text == 'sparse') {
							sparse = parser.getBooleanValue();
						} else if (text == 'Id') {
							Id = parser.getText();
						} else if (text == 'SyncToken') {
							SyncToken = parser.getText();
						} else if (text == 'MetaData') {
							MetaData = new MetaData(parser);
						} else if (text == 'FullyQualifiedName') {
							FullyQualifiedName = parser.getText();
						} else if (text == 'CompanyName') {
							CompanyName = parser.getText();
						} else if (text == 'DisplayName') {
							DisplayName = parser.getText();
						} else if (text == 'PrintOnCheckName') {
							PrintOnCheckName = parser.getText();
						} else if (text == 'Active') {
							Active = parser.getBooleanValue();
						} else if (text == 'DefaultTaxCodeRef') {
							DefaultTaxCodeRef = new DefaultTaxCodeRef(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Customer consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class MetaData {
		public String CreateTime {get;set;} 
		public String LastUpdatedTime {get;set;} 

		public MetaData(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'CreateTime') {
							CreateTime = parser.getText();
						} else if (text == 'LastUpdatedTime') {
							LastUpdatedTime = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'MetaData consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class DefaultTaxCodeRef {
		public String value {get;set;} 

		public DefaultTaxCodeRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'DefaultTaxCodeRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2Apex parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2Apex(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	









}