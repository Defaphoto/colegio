insert into colegio.asignatura values(1,'Matematica');
insert into colegio.asignatura values(2,'Lenguaje');
insert into colegio.asignatura values(3,'Historia');
insert into colegio.asignatura values(4,'Quimica');
insert into colegio.asignatura values(5,'Fisica');
insert into colegio.asignatura values(6,'Biologia');

insert into colegio.colegio values(1,'Colegio Cardenal Jose Maria Caro','Avenida Las Rosas 3610');
insert into colegio.colegio values(2,'Colegio Silva Henriquez','Calle Santo Padre 10840');
insert into colegio.colegio values(3,'Colegio Cristian Garden','Calle Las parcelas 4401');

insert into colegio.profesor values(1,'Jose Miguel Bravo Gonzales','1992/03/09',1,1,'Activo');
insert into colegio.profesor values(2,'Alexis Sebastian Canto Godoy','1990/11/22',2,1,'Activo');
insert into colegio.profesor values(3,'Yaslie Andrea Abarca Gonzales','1991/12/23',3,2,'Activo');
insert into colegio.profesor values(4,'Felipe Andres Fuenzalida Zuniga','1994/01/20',4,2,'Activo');
insert into colegio.profesor values(5,'Patricia Katerin Morales Torres','1990/02/02',5,3,'Activo');
insert into colegio.profesor values(6,'Jacqueline Del Carmen Covarrubia Marchant','1989/07/18',6,3,'Activo');

insert into colegio.alumno values(1,'Daniel Enrique Farias Aravena','2005/01/11');
insert into colegio.alumno values(2,'Brandon Adrian Araya Torres','2004/05/22');
insert into colegio.alumno values(3,'Kevin Bryan Armijo Baez','2003/02/06');
insert into colegio.alumno values(4,'Fabian Hernan Contreras Hidalgo','2004/06/05');
insert into colegio.alumno values(5,'Elizabeth Anaiz Acuña Pardo','2003/11/18');
insert into colegio.alumno values(6,'Felipe Gabriel Bauerle Fernandes','2002/12/14');

insert into colegio.nota values(1,1,1,4.0);
insert into colegio.nota values(2,2,1,6.1);
insert into colegio.nota values(3,3,1,7.0);
insert into colegio.nota values(4,4,1,5.1);
insert into colegio.nota values(5,5,1,3.0);
insert into colegio.nota values(6,6,1,2.2);
insert into colegio.nota values(7,1,1,2.0);
insert into colegio.nota values(8,2,1,3.0);
insert into colegio.nota values(9,3,1,2.0);
insert into colegio.nota values(10,4,1,1.0);
insert into colegio.nota values(11,5,1,2.0);
insert into colegio.nota values(12,6,1,2.0);

insert into colegio.nota values(13,1,2,2.0);
insert into colegio.nota values(14,2,2,3.0);
insert into colegio.nota values(15,3,2,2.0);
insert into colegio.nota values(16,4,2,1.0);
insert into colegio.nota values(17,5,2,2.0);
insert into colegio.nota values(18,6,2,2.0);
insert into colegio.nota values(19,1,2,2.0);
insert into colegio.nota values(20,2,2,3.0);
insert into colegio.nota values(21,3,2,2.0);
insert into colegio.nota values(22,4,2,1.0);
insert into colegio.nota values(23,5,2,2.0);
insert into colegio.nota values(24,6,2,2.0);
insert into colegio.nota values(25,2,2,4.0);
insert into colegio.nota values(26,2,2,4.0);

/*Consulta que obtenga todos los profesores de un colegio ordenados por nombre.*/
select * from colegio.profesor order by colegio.profesor.nombre_profesor asc;


/*Consulta que obtenga todos los alumnos con promedio rojo por asignatura.*/
 SELECT colegio.alumno.nombre_alumno, colegio.asignatura.nombre_asignatura, avg(colegio.nota.nota)
FROM colegio.alumno
 inner JOIN colegio.nota ON colegio.alumno.id_alumno = colegio.nota.id_alumno
 inner join colegio.asignatura on colegio.asignatura.id_asignatura = colegio.nota.id_asignatura_alumno
 group by colegio.alumno.nombre_alumno, colegio.asignatura.nombre_asignatura
 having avg(colegio.nota.nota) <=4.0;
 
 
/*Consulta que contenga el alumno con mejor nota por asignatura.*/
select DISTINCT colegio.alumno.nombre_alumno, colegio.nota.nota,colegio.asignatura.nombre_asignatura from
(SELECT colegio.asignatura.id_asignatura, max(colegio.nota.nota) as nota_maxima
FROM colegio.alumno
 inner JOIN colegio.nota ON colegio.alumno.id_alumno = colegio.nota.id_alumno
 inner join colegio.asignatura on colegio.asignatura.id_asignatura = colegio.nota.id_asignatura_alumno
group by
colegio.asignatura.id_asignatura)  as nota_maxima_asignatura
inner join colegio.nota on nota_maxima_asignatura.id_asignatura=colegio.nota.id_asignatura_alumno
inner join colegio.alumno on colegio.alumno.id_alumno = colegio.nota.id_alumno
inner join colegio.asignatura on colegio.asignatura.id_asignatura = colegio.nota.id_asignatura_alumno
where nota_maxima_asignatura.id_asignatura = colegio.nota.id_asignatura_alumno
and colegio.nota.nota = nota_maxima_asignatura.nota_maxima;












 
 










