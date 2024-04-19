import React, { useState, useEffect } from 'react';
import axios from 'axios';

function CourseList() {
  const [courses, setCourses] = useState([]);

  useEffect(() => {
    fetchCourses();
  }, []);

  const fetchCourses = async () => {
    try {
      const response = await axios.get('/api/course');
      setCourses(response.data);
    } catch (error) {
      console.error('Error fetching courses:', error);
    }
  };

  return (
    <div className="container">
      <h2>Frisbee Golf Courses</h2>
      <ul>
        {courses.map(course => (
          <li key={course.id}>
            <h3>{course.name}</h3>
            <p>Location: {course.location}</p>
            <p>Par: {course.par}</p>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default CourseList;
