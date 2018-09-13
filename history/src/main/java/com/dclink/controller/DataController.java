package com.dclink.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dclink.mapper.MainMapper;
import com.dclink.pojo.Candidate;
import com.dclink.pojo.Council;
import com.dclink.pojo.Election;
import com.dclink.pojo.History;
import com.dclink.pojo.Inspection;
import com.dclink.pojo.Item;
import com.dclink.pojo.Party;
import com.dclink.pojo.Person;
import com.dclink.pojo.Rate;
import com.dclink.pojo.State;
import com.dclink.pojo.Sub;
import com.dclink.pojo.Zone;

@Controller
@RequestMapping("/data")
public class DataController {

	@Autowired
	MainMapper mainMapper;
	
	
	@RequestMapping("/elections.do")
	public @ResponseBody List<Election> elections() {
		List<Election> ret = mainMapper.getAllElection();
		
        return ret;
    }

	@RequestMapping("/states.do")
	public @ResponseBody List<State> states(@RequestParam("election") int election) {
		List<State> ret = mainMapper.getAllState(election);
		
        return ret;
    }
	
	@RequestMapping("/persons.do")
	public @ResponseBody List<Person> persons() {
		List<Person> ret = mainMapper.getPerson();
		
        return ret;
    }

	@RequestMapping("/parties.do")
	public @ResponseBody List<Party> parties() {
		List<Party> ret = mainMapper.getParty();
		
        return ret;
    }

	@RequestMapping("/zones.do")
	public @ResponseBody List<Zone> zones() {
		List<Zone> ret = mainMapper.getZone();
		
        return ret;
    }

	
	@RequestMapping("/items.do")
	public @ResponseBody List<Item> items(@RequestParam("state") int state) {
		List<Item> ret = mainMapper.getItem(state);
		
        return ret;
    }

	@RequestMapping("/candidates.do")
	public @ResponseBody List<Candidate> candidates(@RequestParam("state") int state) {
		List<Candidate> ret = mainMapper.getCandidate(state);
		
        return ret;
    }

	@RequestMapping("/councils.do")
	public @ResponseBody List<Council> councils(@RequestParam("state") int state) {
		List<Council> ret = mainMapper.getCouncil(state);
		
        return ret;
    }

	@RequestMapping("/zoneCandidates.do")
	public @ResponseBody List<Candidate> zoneCandidates(@RequestParam("zone") String zone) {
		List<Candidate> ret = mainMapper.getZoneCandidate(zone);
		
        return ret;
    }

	@RequestMapping("/zoneCouncils.do")
	public @ResponseBody List<Council> zoneCouncils(@RequestParam("zone") String zone) {
		List<Council> ret = mainMapper.getZoneCouncil(zone);
		
        return ret;
    }

	
	@RequestMapping("/subs.do")
	public @ResponseBody List<Sub> subs(@RequestParam("candidate") int candidate) {
		List<Sub> ret = mainMapper.getSubs(candidate);
		
        return ret;
    }

	@RequestMapping("/history.do")
	public @ResponseBody List<History> history(@RequestParam("person") int person) {
		List<History> ret = mainMapper.getHistory(person);
		
        return ret;
    }
	
	@RequestMapping("/zoneHistory.do")
	public @ResponseBody List<Item> zoneHistory(@RequestParam("code") String code) {
		List<Item> ret = mainMapper.getZoneHistory(code);
		
        return ret;
    }

	
	@RequestMapping(value="/inspection.do",method=RequestMethod.GET,params={"person"})
	public @ResponseBody List<Inspection> inspection(@RequestParam("person") int person) {
		List<Inspection> ret = mainMapper.getInspection(person);
		
        return ret;
    }
	
	@RequestMapping(value="/inspection.do",method=RequestMethod.GET,params={})
	public @ResponseBody List<Inspection> allInspection() {
		List<Inspection> ret = mainMapper.getAllInspections();
		
        return ret;
    }

	
	@RequestMapping(value="/search.do")
	public @ResponseBody List<History> search(@RequestParam("name") String name) {
		List<History> ret = mainMapper.search(name);
		
        return ret;
    }
	
	@RequestMapping(value="/rates.do")
	public @ResponseBody List<Rate> rates(@RequestParam("election") int election) {
		List<Rate> ret = mainMapper.getRates(election);
		
        return ret;
    }
	
	@RequestMapping(value="/rrates.do")
	public @ResponseBody List<Rate> rrates(@RequestParam("election") int election) {
		List<Rate> ret = mainMapper.getRRates(election);
		
        return ret;
    }
	
	@RequestMapping(value="/photo.do",method=RequestMethod.PUT)
	public @ResponseBody String photo(@RequestBody int id) {
		mainMapper.photo(id);
		
        return "";
    }

	
	
	@RequestMapping(value="/item.do",method=RequestMethod.POST)
	public @ResponseBody String addItem(@RequestBody State state) {
		mainMapper.addItem(state);
		
        return "";
    }

	@RequestMapping(value="/item.do",method=RequestMethod.PUT)
	public @ResponseBody String editItem(@RequestBody Item item) {
		mainMapper.editItem(item);
		
        return "";
    }

	
	
	@RequestMapping(value="/candidate.do",method=RequestMethod.POST)
	public @ResponseBody String addCandidate(@RequestBody Item item) {
		mainMapper.addCandidate(item);
		
        return "";
    }
	
	@RequestMapping(value="/candidate.do",method=RequestMethod.PUT)
	public @ResponseBody String editCandidate(@RequestBody Candidate candidate) {
		mainMapper.editCandidate(candidate);
		
        return "";
    }
	
	
	@RequestMapping(value="/council.do",method=RequestMethod.POST)
	public @ResponseBody String addCouncil(@RequestBody Item item) {
		mainMapper.addCouncil(item);
		
        return "";
    }
	
	@RequestMapping(value="/council.do",method=RequestMethod.PUT)
	public @ResponseBody String editCouncil(@RequestBody Council council) {
		mainMapper.editCouncil(council);
		
        return "";
    }
	
	@RequestMapping(value="/person.do",method=RequestMethod.POST)
	public @ResponseBody String addPerson(@RequestBody Person person) {
		mainMapper.addPerson(person);
		
        return "";
    }
	
	@RequestMapping(value="/party.do",method=RequestMethod.POST)
	public @ResponseBody String addParty(@RequestBody Party party) {
		mainMapper.addParty(party);
		
        return "";
    }
	
	@RequestMapping(value="/zone.do",method=RequestMethod.POST)
	public @ResponseBody String addZone(@RequestBody Zone zone) {
		mainMapper.addZone(zone);
		
        return "";
    }

	
	@RequestMapping(value="/inspection.do",method=RequestMethod.POST)
	public @ResponseBody String addInspection() {
		
		mainMapper.addInspection(new Inspection());
		
        return "";
    }

	@RequestMapping(value="/copy.do",method=RequestMethod.POST)
	public @ResponseBody String copy(@RequestBody Inspection inspection) {
		mainMapper.addInspection(inspection);
		
        return "";
    }

	@RequestMapping(value="/inspection.do",method=RequestMethod.PUT)
	public @ResponseBody String editInspection(@RequestBody Inspection inspection) {
		mainMapper.editInspection(inspection);
		
        return "";
    }

	
	@RequestMapping(value="/sub.do",method=RequestMethod.POST)
	public @ResponseBody String addSub(@RequestBody Candidate candidate) {
		mainMapper.addSub(candidate.getId());
		
        return "";
    }
	
	@RequestMapping(value="/sub.do",method=RequestMethod.PUT)
	public @ResponseBody String editSub(@RequestBody Sub sub) {
		mainMapper.editSub(sub);
		
        return "";
    }

}