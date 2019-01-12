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
import com.dclink.pojo.Building;
import com.dclink.pojo.Candidate;
import com.dclink.pojo.Council;
import com.dclink.pojo.Election;
import com.dclink.pojo.Faction;
import com.dclink.pojo.Hero;
import com.dclink.pojo.History;
import com.dclink.pojo.Inspection;
import com.dclink.pojo.Item;
import com.dclink.pojo.Party;
import com.dclink.pojo.Person;
import com.dclink.pojo.Rate;
import com.dclink.pojo.Road;
import com.dclink.pojo.Scenario;
import com.dclink.pojo.Snapshot;
import com.dclink.pojo.SoldierClass;
import com.dclink.pojo.State;
import com.dclink.pojo.Sub;
import com.dclink.pojo.Trait;
import com.dclink.pojo.Weapon;
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


	@RequestMapping(value="/unuse.do",method=RequestMethod.PUT)
	public @ResponseBody String unuse(@RequestBody int id) {
		mainMapper.unuse(id);
		
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

	@RequestMapping(value="/use.do",method=RequestMethod.PUT)
	public @ResponseBody String setUses(@RequestBody Snapshot snapshot) {
		
		List<Boolean> list = mainMapper.getScenarioCity(snapshot);
		if(list.size()>0) {
			mainMapper.setUses(snapshot);
			
		}else {
			mainMapper.insertScenarioCity(snapshot);
			mainMapper.insertScenarioRoad(snapshot);
			
		}
		
        return "";
    }



	
	@RequestMapping(value="/snapshot.do",method=RequestMethod.PUT)
	public @ResponseBody String setSnapshot(@RequestBody Snapshot snapshot) {
		mainMapper.setSnapshot(snapshot);
		
        return "";
    }

	@RequestMapping(value="/snapshot.do",method=RequestMethod.POST)
	public @ResponseBody String addSnapshot(@RequestBody Snapshot snapshot) {
		mainMapper.addSnapshot(snapshot);
		
        return "";
    }

	@RequestMapping(value="/snapshot/sub.do",method=RequestMethod.POST)
	public @ResponseBody String addSnapshotSub(@RequestBody Snapshot snapshot) {
		mainMapper.addSnapshotSub(snapshot);
		
        return "";
    }
	
	@RequestMapping(value="/snapshot/sub.do",method=RequestMethod.PUT)
	public @ResponseBody String editSnapshotSub(@RequestBody Sub sub) {
		mainMapper.editSnapshotSub(sub);
		
        return "";
    }

	@RequestMapping(value="/snapshot/sub.do",method=RequestMethod.DELETE)
	public @ResponseBody String removeSnapshotSub(@RequestParam("id") int id) {
		mainMapper.removeSnapshotSub(id);
		
        return "";
    }

	
	@RequestMapping(value="/scenario.do",method=RequestMethod.GET)
	public @ResponseBody List<Scenario> getScenario() {
		List<Scenario> ret = mainMapper.getScenario();
		
        return ret;
    }


	@RequestMapping(value="/scenario.do",method=RequestMethod.POST)
	public @ResponseBody void addScenario(@RequestBody Scenario scenario) {
		mainMapper.addScenario(scenario);
		mainMapper.addScenarioCities();
		mainMapper.addScenarioRoads();

    }

	
	
	@RequestMapping(value="/snapshot.do",method=RequestMethod.GET)
	public @ResponseBody List<Snapshot> getSnapshot(@RequestParam("year") int year) {
		List<Snapshot> ret = mainMapper.getSnapshot(year);
		
        return ret;
    }

	@RequestMapping(value="/city/snapshot.do",method=RequestMethod.GET)
	public @ResponseBody List<Snapshot> getCitySnapshot(@RequestParam("city") int city) {
		List<Snapshot> list = mainMapper.getCitySnapshot(city);
		
        return list;
    }
	
	@RequestMapping(value="/scenarioSnapshot.do",method=RequestMethod.GET)
	public @ResponseBody List<Snapshot> getScenarioSnapshot() {
		List<Snapshot> ret = mainMapper.getScenarioSnapshot();
		
        return ret;
    }

	@RequestMapping(value="/allScenarioSnapshot.do",method=RequestMethod.GET)
	public @ResponseBody List<Snapshot> getAllScenarioSnapshot(@RequestParam("scenario") int scenario) {
		List<Snapshot> ret = mainMapper.getAllScenarioSnapshot(scenario);
		
        return ret;
    }

	
	@RequestMapping(value="/road.do",method=RequestMethod.GET)
	public @ResponseBody List<Road> getRoad(@RequestParam("scenario") int scenario) {
		List<Road> ret = mainMapper.getRoads(scenario);
		
        return ret;
    }

	@RequestMapping(value="/road.do",method=RequestMethod.POST)
	public @ResponseBody  void addRoad(@RequestBody Road road) {
		
		List<Integer> list = mainMapper.getRoad(road);
		if(list.size() == 0) {			
			mainMapper.addRoad(road);
			mainMapper.addScenarioRoad(road);
		}else {
			road.setId(list.get(0));
			mainMapper.addScenarioRoadWithId(road);			
		}
		
    }

	@RequestMapping(value="/road.do",method=RequestMethod.DELETE)
	public @ResponseBody  void removeRoad(@RequestParam("id") int id) {
		
		mainMapper.removeRoad(id);
		
    }

	
	@RequestMapping("/cities.do")
	public @ResponseBody List<Snapshot> cities() {
		List<Snapshot> ret = mainMapper.getCities();
		
        return ret;
    }

	@RequestMapping(value="/faction.do",method=RequestMethod.GET)
	public @ResponseBody List<Faction> getFaction() {
		List<Faction> ret = mainMapper.getFaction();
		
        return ret;
    }

	@RequestMapping(value="/faction.do",method=RequestMethod.POST)
	public @ResponseBody void addFaction(@RequestBody Faction faction) {
		mainMapper.addFaction(faction);
		
    }

	
	@RequestMapping(value="/faction.do",method=RequestMethod.PUT)
	public @ResponseBody void editFaction(@RequestBody Faction faction) {
		mainMapper.editFaction(faction);
		
    }

	
	@RequestMapping(value="/building.do",method=RequestMethod.GET)
	public @ResponseBody List<Building> getBuildings() {
		List<Building> ret = mainMapper.getBuildings();
		
        return ret;
    }

	@RequestMapping(value="/trait.do",method=RequestMethod.GET)
	public @ResponseBody List<Trait> getTraits() {
		List<Trait> ret = mainMapper.getTrait();
		
        return ret;
    }
	
	@RequestMapping(value="/city/sub.do",method=RequestMethod.GET)
	public @ResponseBody List<Sub> getCitySubs() {
		List<Sub> ret = mainMapper.getCitySub();
		
        return ret;
    }

	@RequestMapping(value="/snapshot/sub.do",method=RequestMethod.GET)
	public @ResponseBody List<Sub> getSnapshotSubs() {
		List<Sub> ret = mainMapper.getSnapshotSubs();
		
        return ret;
    }

	
	
	@RequestMapping(value="/city/sub.do",method=RequestMethod.POST)
	public @ResponseBody void addCitySubs(@RequestBody Sub sub) {
		mainMapper.addCitySubs(sub);
    }

	@RequestMapping(value="/building/sub.do",method=RequestMethod.GET)
	public @ResponseBody List<Sub> getBuildingSubs() {
		List<Sub> ret = mainMapper.getBuildingSub();
		
        return ret;
    }	
	
	@RequestMapping(value="/weapon.do",method=RequestMethod.GET)
	public @ResponseBody List<Weapon> getWeapons() {
		List<Weapon> ret = mainMapper.getWeapons();
		
        return ret;
    }

	@RequestMapping(value="/weapon/sub.do",method=RequestMethod.GET)
	public @ResponseBody List<Sub> getWeaponSub() {
		List<Sub> ret = mainMapper.getWeaponSub();
		
        return ret;
    }

	
	@RequestMapping(value="/soldierClass.do",method=RequestMethod.GET)
	public @ResponseBody List<SoldierClass> getSoldierClass() {
		List<SoldierClass> ret = mainMapper.getSoldierClass();
		
        return ret;
    }
	
	@RequestMapping(value="/soldierClassSub.do",method=RequestMethod.GET)
	public @ResponseBody List<Sub> getSoldierClassSub() {
		List<Sub> ret = mainMapper.getSoldierClassSub();
		
        return ret;
    }
	
	@RequestMapping(value="/hero.do",method=RequestMethod.GET)
	public @ResponseBody List<Hero> getHeroes() {
		List<Hero> ret = mainMapper.getHeroes();
		
        return ret;
    }

	@RequestMapping(value="/hero.do",method=RequestMethod.POST)
	public @ResponseBody void addHero(@RequestBody Hero hero) {
		mainMapper.addHero(hero);
    }

	@RequestMapping(value="/hero.do",method=RequestMethod.PUT)
	public @ResponseBody void editHero(@RequestBody Hero hero) {
		mainMapper.editHero(hero);
    }


	
	@RequestMapping(value="/hero/sub.do",method=RequestMethod.GET)
	public @ResponseBody List<Sub> getHeroSubs() {
		List<Sub> ret = mainMapper.getHeroSubs();
		
        return ret;
    }
	
	
}