package com.dclink.pojo;

import java.util.List;

public class Item {
	
	int id;
	String name;
	String link;
	int state;
	int party;
	int person;
	int history;
	String code;
	String parent;
	String type;
	String title;
	String zone;
	String election;
	int x;
	int y;
	
	List<Candidate> candidates;
	
	
	public String getZone() {
		return zone;
	}
	public void setZone(String zone) {
		this.zone = zone;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getParty() {
		return party;
	}
	public void setParty(int party) {
		this.party = party;
	}
	public List<Candidate> getCandidates() {
		return candidates;
	}
	public void setCandidates(List<Candidate> candidates) {
		this.candidates = candidates;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public int getHistory() {
		return history;
	}
	public void setHistory(int history) {
		this.history = history;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getParent() {
		return parent;
	}
	public void setParent(String parent) {
		this.parent = parent;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getElection() {
		return election;
	}
	public void setElection(String election) {
		this.election = election;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	
	
}
