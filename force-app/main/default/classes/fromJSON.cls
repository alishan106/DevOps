public class fromJSON {
	public class Messages {
		public String to;
		public String body;
	}

	public String accountreference;
	public List<Messages> messages;
	
	public static fromJSON parse(String json) {
		return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
	}
}