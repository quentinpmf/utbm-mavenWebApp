/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.utbm.mavenproject.controller;

import fr.utbm.mavenproject.entity.Course;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author qboudino
 */
public class DefaultCourseController 
{
    private static EntityManager em;
    
    public void createCourse(String title) 
    {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("fr.utbm_mavenproject_jar_1.0-SNAPSHOTPU");
        em = emf.createEntityManager();
        em.getTransaction().begin();
        Course cou = new Course();
        cou.setTitle(title);
        em.persist(cou);
        em.getTransaction().commit();
    }
    
}
