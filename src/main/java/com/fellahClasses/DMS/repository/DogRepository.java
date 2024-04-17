package com.fellahClasses.DMS.repository;
import java.util.List;

/**
 * @author Jayanth Anumula
 * Due: 04/5/24
 */
import org.springframework.data.repository.CrudRepository;

import com.fellahClasses.DMS.Models.Dog;

public interface DogRepository extends CrudRepository<Dog,Integer> {
	
	List<Dog> findByName(String name);

}
