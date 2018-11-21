package com.gfan.report.frame.util;

public class DataBaseCommend {

	
	//all   game_channel
	private static String gameChannelUrl = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.url.query");
	private static String gameChannelUserName = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.user.query");
	private static String gameChannelPassWord = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.password.query");
	
	//dis_channel  gfan_stat
	private static String gfanStatUrl = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.url.query.distribute");
	private static String gfanStatUserName = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.user.query.distribute");
	private static String gfanStatPassWord = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.password.query.distribute");
	
	//base_game_channel  gfan_union_game
	private static String gfanUnionGameUrl = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.url.query.uniongame");
	private static String gfanUnionGameUserName = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.user.query.uniongame");
	private static String gfanUnionGamePassWord = GetPropertyUtil.getPropertyByName("jdbc", "jdbc.password.query.uniongame");
	
	
	public static String getGameChannelUrl() {
		return gameChannelUrl;
	}
	public static void setGameChannelUrl(String gameChannelUrl) {
		DataBaseCommend.gameChannelUrl = gameChannelUrl;
	}
	public static String getGameChannelUserName() {
		return gameChannelUserName;
	}
	public static void setGameChannelUserName(String gameChannelUserName) {
		DataBaseCommend.gameChannelUserName = gameChannelUserName;
	}
	public static String getGameChannelPassWord() {
		return gameChannelPassWord;
	}
	public static void setGameChannelPassWord(String gameChannelPassWord) {
		DataBaseCommend.gameChannelPassWord = gameChannelPassWord;
	}
	public static String getGfanStatUrl() {
		return gfanStatUrl;
	}
	public static void setGfanStatUrl(String gfanStatUrl) {
		DataBaseCommend.gfanStatUrl = gfanStatUrl;
	}
	public static String getGfanStatUserName() {
		return gfanStatUserName;
	}
	public static void setGfanStatUserName(String gfanStatUserName) {
		DataBaseCommend.gfanStatUserName = gfanStatUserName;
	}
	public static String getGfanStatPassWord() {
		return gfanStatPassWord;
	}
	public static void setGfanStatPassWord(String gfanStatPassWord) {
		DataBaseCommend.gfanStatPassWord = gfanStatPassWord;
	}
	public static String getGfanUnionGameUrl() {
		return gfanUnionGameUrl;
	}
	public static void setGfanUnionGameUrl(String gfanUnionGameUrl) {
		DataBaseCommend.gfanUnionGameUrl = gfanUnionGameUrl;
	}
	public static String getGfanUnionGameUserName() {
		return gfanUnionGameUserName;
	}
	public static void setGfanUnionGameUserName(String gfanUnionGameUserName) {
		DataBaseCommend.gfanUnionGameUserName = gfanUnionGameUserName;
	}
	public static String getGfanUnionGamePassWord() {
		return gfanUnionGamePassWord;
	}
	public static void setGfanUnionGamePassWord(String gfanUnionGamePassWord) {
		DataBaseCommend.gfanUnionGamePassWord = gfanUnionGamePassWord;
	}
	

	public static void main(String[] args) {
		System.out.println(gameChannelUrl);
	}
	
	
	
}
