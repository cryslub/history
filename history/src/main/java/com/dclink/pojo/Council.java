package com.dclink.pojo;

import java.util.List;

public class Council
{
	
	int id;
	int item;
	int person;
	String link;
	int party;
	String txt;
	List<Sub> subs;
	int count;
	int history;
	String type;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public int getParty() {
		return party;
	}
	public void setParty(int party) {
		this.party = party;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
	}
	public List<Sub> getSubs() {
		return subs;
	}
	public void setSubs(List<Sub> subs) {
		this.subs = subs;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getHistory() {
		return history;
	}
	public void setHistory(int history) {
		this.history = history;
	}
	public int getItem() {
		return item;
	}
	public void setItem(int item) {
		this.item = item;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
}
