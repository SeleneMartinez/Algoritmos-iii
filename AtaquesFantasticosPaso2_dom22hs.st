!classDefinition: #Alerta category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #Alerta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Alerta class' category: 'AtaquesFantasticosPaso2'!
Alerta class
	instanceVariableNames: 'daño'!

!Alerta class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:02:35'!
bofetada
	daño:= 2 * pv.! !

!Alerta class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 19:26:22'!
dañoPorConcentracion
	^daño.! !

!Alerta class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:06:19'!
distraer
 ^Distraido inicial.! !

!Alerta class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:06:13'!
distraerOAlertar: dañoRecibido
 (dañoRecibido > (0 * pv)) ifTrue: [^Alerta inicial] ifFalse: [^ self distraer].! !

!Alerta class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:02:26'!
inicial
daño:=0 *pv.
^self.! !


!Alerta class methodsFor: '--** private fileout/in **--' stamp: 'alm 9/18/2022 22:15:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	daño := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).! !


!classDefinition: #CombatienteHumanoArthas category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatienteHumanoArthas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteHumanoArthas class' category: 'AtaquesFantasticosPaso2'!
CombatienteHumanoArthas class
	instanceVariableNames: 'bonificadorDeAgilidad enemigos puntosDeVida dañoAInfligir dañoAAbsorber estrategia concentracion'!

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:49:15'!
atacar
	| enemigoElegido enemigosEnCombate |
	enemigos isEmpty ifTrue: [^self].
	enemigosEnCombate := enemigos select: [:enemigo | enemigo estaEnCombate ].
	enemigoElegido := estrategia value: enemigosEnCombate.
	self atacarA: enemigoElegido.! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:15:50'!
atacarA: unCombatiente 
	(puntosDeVida <= (0 * pv)) ifFalse: [	unCombatiente recibirDaño: dañoAInfligir].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'pal 8/23/2022 12:59:21'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:55:52'!
estaEnCombate
	^ puntosDeVida > (0 * pv).! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'JMB 9/11/2022 12:05:22'!
focalizarEnElMasHerido
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar detectMin: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'JMB 9/11/2022 12:05:32'!
focalizarEnElMasSano
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar detectMax: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'SM 9/18/2022 19:55:20'!
prepararseParaElCombate
	puntosDeVida := 20*pv.
	dañoAInfligir := 2*pv.
	dañoAAbsorber := 0*pv.
	bonificadorDeAgilidad:= 1 * pv.
	concentracion:= Alerta inicial.
	enemigos := #().
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar anyOne ].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'pal 8/23/2022 23:49:24'!
puntosDeVida
	^puntosDeVida! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'alm 9/16/2022 18:51:26'!
recibirDaño:  unaCantidadDeDaño
	| dañoADescontar |
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber - bonificadorDeAgilidad) max: 0*pv.
	puntosDeVida := puntosDeVida - dañoADescontar.! !


!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:27:09'!
usarArmaduraDeCuero
	dañoAAbsorber := 2*pv.! !

!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:27:15'!
usarArmaduraDeMetal
	dañoAAbsorber := 6*pv.! !

!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:27:19'!
usarEspada
	dañoAInfligir := 8*pv.! !

!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:27:23'!
usarHacha
	dañoAInfligir := 10*pv.! !


!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 17:15:08'!
estaHerido
	^puntosDeVida < (20 * pv).! !

!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:24:18'!
noEstaHerido
 ^ puntosDeVida =(20 *pv).! !

!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:53:34'!
tienePuntosDeVida: puntosDeVidaAComparar 
	^ puntosDeVida = puntosDeVidaAComparar.! !


!CombatienteHumanoArthas class methodsFor: '--** private fileout/in **--' stamp: 'alm 9/18/2022 22:15:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	bonificadorDeAgilidad := (SimpleMeasure basicNew instVarAt: 1 put: 1; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	enemigos := ((Array new: 1) at: 1 put: CombatienteOrcoOlgra; yourself).
	puntosDeVida := (SimpleMeasure basicNew instVarAt: 1 put: 2; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	dañoAInfligir := (SimpleMeasure basicNew instVarAt: 1 put: 2; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	dañoAAbsorber := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	estrategia := ((SerializableBlockClosure basicNew instVarAt: 1 put: CombatienteHumanoArthas; instVarAt: 2 put: '[ :argm6_1 |
	argm6_1 anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).
	concentracion := Alerta.! !


!classDefinition: #CombatienteOrcoMankrik category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatienteOrcoMankrik
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteOrcoMankrik class' category: 'AtaquesFantasticosPaso2'!
CombatienteOrcoMankrik class
	instanceVariableNames: 'bonificadorFuerza enemigos puntosDeVida dañoAInfligir dañoAAbsorber estrategia concentracion'!

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:59:28'!
atacar
	| enemigoElegido enemigosEnCombate |
	enemigos isEmpty ifTrue: [^self].
	enemigosEnCombate := enemigos select: [:enemigo | enemigo estaEnCombate ].
	enemigoElegido := estrategia value: enemigosEnCombate.
	self atacarA: enemigoElegido.! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:16:53'!
atacarA: unCombatiente 
	(puntosDeVida <= (0 * pv)) ifFalse: [	unCombatiente recibirDaño: dañoAInfligir + bonificadorFuerza].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'pal 8/23/2022 23:51:54'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'JMB 9/11/2022 12:03:12'!
focalizarEnElMasHerido
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar detectMin: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'JMB 9/11/2022 12:03:31'!
focalizarEnElMasSano
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar detectMax: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'SM 9/18/2022 19:55:28'!
prepararseParaElCombate
	puntosDeVida := 20*pv.
	dañoAInfligir := 2*pv.
	dañoAAbsorber := 0*pv.
	bonificadorFuerza:= 2 * pv.
	concentracion:= Alerta inicial.
	enemigos := #().
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar anyOne ].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'pal 8/23/2022 23:51:54'!
puntosDeVida
	^puntosDeVida! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'SM 9/18/2022 20:10:25'!
recibirDaño:  unaCantidadDeDaño
	| dañoADescontar dañoPorConcentracion |
	dañoPorConcentracion := self calcularDañoPorConcentracion: unaCantidadDeDaño - dañoAAbsorber.
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber + dañoPorConcentracion)max: 0*pv.
	puntosDeVida := puntosDeVida - dañoADescontar.! !


!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:26:48'!
usarArmaduraDeCuero
	dañoAAbsorber := 2*pv.! !

!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:26:53'!
usarArmaduraDeMetal
	dañoAAbsorber := 6*pv.! !

!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:26:57'!
usarEspada
	dañoAInfligir := 8*pv.! !

!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:27:02'!
usarHacha
	dañoAInfligir := 10*pv.! !


!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:10:51'!
calcularDañoPorConcentracion: dañoRecibido.
	concentracion:= concentracion distraerOAlertar: dañoRecibido.
	^concentracion dañoPorConcentracion.! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 17:41:45'!
estaEnCombate
	^ puntosDeVida > (0 * pv).! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:32:51'!
estaHerido
	^puntosDeVida < (20 * pv).! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:29:20'!
noEstaHerido
	^ puntosDeVida = (20*pv).
! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:34:08'!
tienePuntosDeVida: puntosDeVidaAComparar 
	^ puntosDeVida = puntosDeVidaAComparar.! !


!CombatienteOrcoMankrik class methodsFor: '--** private fileout/in **--' stamp: 'alm 9/18/2022 22:15:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	bonificadorFuerza := (SimpleMeasure basicNew instVarAt: 1 put: 2; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	enemigos := #().
	puntosDeVida := (SimpleMeasure basicNew instVarAt: 1 put: 20; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	dañoAInfligir := (SimpleMeasure basicNew instVarAt: 1 put: 2; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	dañoAAbsorber := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	estrategia := ((SerializableBlockClosure basicNew instVarAt: 1 put: CombatienteOrcoMankrik; instVarAt: 2 put: '[ :argm6_1 |
	argm6_1 anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).
	concentracion := Alerta.! !


!classDefinition: #CombatienteOrcoOlgra category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatienteOrcoOlgra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteOrcoOlgra class' category: 'AtaquesFantasticosPaso2'!
CombatienteOrcoOlgra class
	instanceVariableNames: 'concentracion estrategia dañoAAbsorber dañoAInfligir puntosDeVida enemigos estaDistraido bonificadorFuerza bonusPorConcentracion'!

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:54:54'!
atacar
	| enemigoElegido enemigosEnCombate |
	enemigos isEmpty ifTrue: [^self].
	enemigosEnCombate := enemigos select: [:enemigo | enemigo estaEnCombate ].
	enemigoElegido := estrategia value: enemigosEnCombate.
	self atacarA: enemigoElegido.! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:14:06'!
atacarA: unCombatiente 
	(puntosDeVida <= (0 * pv)) ifFalse: [	unCombatiente recibirDaño: dañoAInfligir + bonificadorFuerza].! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'pal 8/23/2022 23:50:14'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'alm 9/18/2022 17:50:12'!
estaEnCombate
	^ puntosDeVida > (0 * pv).! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'JMB 9/11/2022 12:01:25'!
focalizarEnElMasHerido
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar detectMin: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'JMB 9/11/2022 12:01:39'!
focalizarEnElMasSano
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar detectMax: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'SM 9/18/2022 19:55:36'!
prepararseParaElCombate
	puntosDeVida := 20*pv.
	dañoAInfligir := 2*pv.
	dañoAAbsorber := 0*pv.
	bonificadorFuerza:= 1 * pv.
	concentracion:= Alerta inicial.
	enemigos := #().
	estrategia := [:posiblesEnemigosAAtacar | posiblesEnemigosAAtacar anyOne ].
	bonusPorConcentracion := 0 * pv.! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'pal 8/23/2022 23:50:14'!
puntosDeVida
	^puntosDeVida! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'SM 9/18/2022 20:10:16'!
recibirDaño:  unaCantidadDeDaño
	| dañoADescontar dañoPorConcentracion |
	dañoPorConcentracion := self calcularDañoPorConcentracion: unaCantidadDeDaño - dañoAAbsorber.
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber + dañoPorConcentracion)max: 0*pv.
	puntosDeVida := puntosDeVida - dañoADescontar.! !


!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:28:52'!
usarArmaduraDeCuero
	dañoAAbsorber := 2*pv.! !

!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:28:57'!
usarArmaduraDeMetal
	dañoAAbsorber := 6*pv.! !

!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:29:03'!
usarEspada
	dañoAInfligir := 8*pv.! !

!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'JMB 9/14/2022 00:29:08'!
usarHacha
	dañoAInfligir := 10*pv.! !


!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 19:37:34'!
calcularDañoPorConcentracion: dañoRecibido.
	concentracion:= concentracion distraerOAlertar: dañoRecibido.
	^concentracion dañoPorConcentracion.! !

!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:31:12'!
estaHerido
	^puntosDeVida < (20 * pv).! !

!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:27:42'!
noEstaHerido
	^puntosDeVida = (20 * pv).! !

!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'alm 9/16/2022 18:22:23'!
tienePuntosDeVida: puntosDeVidaAComparar 
	^ puntosDeVida = puntosDeVidaAComparar.! !


!CombatienteOrcoOlgra class methodsFor: '--** private fileout/in **--' stamp: 'alm 9/18/2022 22:15:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	concentracion := Alerta.
	estrategia := ((SerializableBlockClosure basicNew instVarAt: 1 put: CombatienteOrcoOlgra; instVarAt: 2 put: '[ :argm6_1 |
	argm6_1 anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).
	dañoAAbsorber := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	dañoAInfligir := (SimpleMeasure basicNew instVarAt: 1 put: 2; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	puntosDeVida := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	enemigos := ((Array new: 1) at: 1 put: CombatienteHumanoArthas; yourself).
	estaDistraido := false.
	bonificadorFuerza := (SimpleMeasure basicNew instVarAt: 1 put: 1; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).
	bonusPorConcentracion := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).! !


!classDefinition: #CombatientesTest category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatientesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatientesTest class' category: 'AtaquesFantasticosPaso2'!
CombatientesTest class
	instanceVariableNames: ''!

!CombatientesTest class methodsFor: '--** private fileout/in **--' stamp: 'JMB 9/14/2022 00:19:03'!
initialize

	"Este método está para crear unidades. No se debe tocar"

	| puntosDeVida |
	puntosDeVida := BaseUnit named: 'puntosDeVida' sign: 'pv'.

	Smalltalk at: #pv put: puntosDeVida.
	Smalltalk at: #puntosDeVida put: puntosDeVida.! !


!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'pal 8/25/2022 00:54:04'!
combatienteHumanoArthas
	^CombatienteHumanoArthas ! !

!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'pal 8/25/2022 00:54:34'!
combatienteOrcoMankrik
	^CombatienteOrcoMankrik ! !

!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'pal 8/25/2022 00:54:12'!
combatienteOrcoOlgra
	^CombatienteOrcoOlgra ! !

!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'pal 8/25/2022 00:53:32'!
comenzarUnNuevoCombate
	CombatienteHumanoArthas prepararseParaElCombate .
	CombatienteOrcoOlgra prepararseParaElCombate .
	CombatienteOrcoMankrik prepararseParaElCombate .! !


!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/14/2022 00:20:06'!
test01CuandoArthasAtacaAOlgraLeHaceDaño
	
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe tener 18 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/14/2022 00:20:11'!
test02CuandoArthasAtacaMasDeUnaVezAOlgraLeHaceDañoEnCadaAtaque

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe tener 16 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/14/2022 00:20:17'!
test03CuandoArthasAtacaConUnHachaHace10DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarHacha.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 10*pv) description: 'Olgra debe tener 10 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/14/2022 00:20:21'!
test04CuandoArthasAtacaConUnaEspadaHace8DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarEspada.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 12*pv) description: 'Olgra debe tener 12 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/14/2022 00:20:27'!
test05CuandoOlgraUsaUnaArmaduraDeCueroResuceLosAtaquesCon2DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarEspada.
	self combatienteOrcoOlgra usarArmaduraDeCuero.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 14*pv) description: 'Olgra debe tener 14 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/14/2022 00:20:33'!
test06CuandoOlgraUsaUnaArmaduraDeMetalResuceLosAtaquesCon6DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarEspada.
	self combatienteOrcoOlgra usarArmaduraDeMetal.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe tener 18 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'JMB 9/10/2022 16:45:40'!
test07CuandoOlgraUsaUnaArmaduraResuceElDañoPeroNoRecuperaPuntosDeVida

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarArmaduraDeMetal.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido description: 'Olgra debe tener los puntos de vida completos'.! !


!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'JMB 9/10/2022 16:55:02'!
test08CuandoArthasNoTieneEnemigosNoAtacaANadie
	self comenzarUnNuevoCombate .
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido description: 'Olgra debe tener los puntos de vida completos'.
	Assert isTrue: self combatienteOrcoMankrik noEstaHerido description: 'Mankrik debe tener los puntos de vida completos'.
	
	! !

!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'JMB 9/10/2022 15:24:46'!
test09CuandoArthasTieneEnemigosAtacaAUno
	| soloOlgraEstaHerido soloMankrikEstaHerido |
	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	
	self combatienteHumanoArthas atacar.
	
	soloOlgraEstaHerido := self combatienteOrcoOlgra estaHerido and: [self combatienteOrcoMankrik noEstaHerido ].
	soloMankrikEstaHerido := self combatienteOrcoMankrik estaHerido and: [self combatienteOrcoOlgra noEstaHerido ].
	Assert isTrue: (soloOlgraEstaHerido or: [soloMankrikEstaHerido]).! !

!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'JMB 9/14/2022 00:20:44'!
test10CuandoArthasTieneComoEstrategiaAtacarAlMasHeridoDañaAlQueEstaMasHerido
	
	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra .	
	self combatienteHumanoArthas focalizarEnElMasHerido.
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe tener 16 puntos de vida'.
	! !

!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'JMB 9/14/2022 00:20:51'!
test11CuandoArthasTieneComoEstrategiaAtacarAlMasSanoDañaAlQueEstaMenosHerido
	
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas usarEspada.
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.	
	self combatienteHumanoArthas focalizarEnElMasSano.
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 12*pv) description: 'Olgra debe tener 12 puntos de vida'.
	! !


!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:38:50'!
test12CuandoOlgraAtacaConSusPuñosAMankrikLeHace2DeDañoMas1PorFuerza
	
	self comenzarUnNuevoCombate.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 17*pv) description: 'Mankrik debe tener 17 puntos de vida (20 inicial - 2 por puños - 1 por fuerza)'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:38:32'!
test13CuandoMankrikAtacaConSusPuñosAOlgraLeHace2DeDañoMas2PorFuerza
	
	self comenzarUnNuevoCombate.
	
	self combatienteOrcoMankrik atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe tener 16 puntos de vida (20 inicial - 2 por puños - 2 por fuerza)'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:39:42'!
test14CuandoMankrikAtacaAArthasLeHaceDañoReducidoEn1PorSuAgilidad
	
	self comenzarUnNuevoCombate.
	
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas.

	Assert 
		isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 17*pv) 
		description: 'Arthas debe tener 17 puntos de vida (20 inicial - 2 por puños - 2 por fuerza + 1 agilidad de Arthas)'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:21:12'!
test15CuandoOlgraAtacaConUnHachaHace10DeDañoMas1PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarHacha.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 9*pv) description: 'Olgra debe tener 9 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:21:17'!
test16CuandoOlgraAtacaConUnaEspadaHace8DeDañoMas1PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 11*pv) description: 'Mankrik debe tener 11 puntos de vida'.
	! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:41:17'!
test17CuandoMankrikAtacaConUnHachaHace10DeDañoMas2PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarHacha.
	
	self combatienteOrcoMankrik atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 8*pv) description: 'Olgra debe tener 8 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:41:26'!
test18CuandoMankrikAtacaConUnaEspadaHace8DeDañoMas2PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarEspada.
	
	self combatienteOrcoMankrik atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 10*pv) description: 'Olgra debe tener 10 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:21:35'!
test19CuandoMankrikUsaUnaArmaduraDeCueroResuceLosAtaquesCon2DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteOrcoMankrik usarArmaduraDeCuero.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 13*pv) description: 'Mankrik debe tener 13 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:21:40'!
test20CuandoMankrikUsaUnaArmaduraDeMetalResuceLosAtaquesCon6DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteOrcoMankrik usarArmaduraDeMetal.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 17*pv) description: 'Mankrik debe tener 17 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:21:44'!
test21CuandoArthasUsaUnaArmaduraDeCueroResuceLosAtaquesCon2DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteHumanoArthas usarArmaduraDeCuero.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 14*pv) description: 'Arthas debe tener 14 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'JMB 9/14/2022 00:21:49'!
test22CuandoArthasUsaUnaArmaduraDeMetalResuceLosAtaquesCon6DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteHumanoArthas usarArmaduraDeMetal.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 18*pv) description: 'Arthas debe tener 18 puntos de vida'.! !


!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'JMB 9/10/2022 15:18:22'!
test23CuandoArthasEstaFueraDeCombateNoHaceDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarHacha.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isFalse: self combatienteOrcoOlgra estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'JMB 9/10/2022 16:52:19'!
test24CuandoOlgraEstaFueraDeCombateNoHaceDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarHacha.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	Assert isFalse: self combatienteHumanoArthas estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'JMB 9/14/2022 21:30:22'!
test25CuandoMankrikEstaFueraDeCombateNoHaceDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarHacha.
	
	self arthasConHachaDejaFueraDeCombateAMankrik.
	
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas.
	
	Assert isFalse: self combatienteHumanoArthas estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'JMB 9/14/2022 22:41:18'!
test26ArthasNoAtacaALosEnemigosFueraDeCombate

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas focalizarEnElMasHerido.	
	self arthasConHachaDejaFueraDeCombateAMankrik.
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'JMB 9/14/2022 22:41:41'!
test27OlgraNoAtacaALosEnemigosFueraDeCombate

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra focalizarEnElMasHerido.
	self olgraConHachaDejaFueraDeCombateAMankrik.
	self combatienteOrcoOlgra enemigos: {self combatienteHumanoArthas. self combatienteOrcoMankrik .}.
	
	self combatienteOrcoOlgra atacar.
	
	Assert isTrue: self combatienteHumanoArthas estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'JMB 9/14/2022 22:36:55'!
test28MankrikNoAtacaALosEnemigosFueraDeCombate

	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik focalizarEnElMasHerido.
	self mankrikConHachaDejaFueraDeCombateAArthas.
	self combatienteOrcoMankrik enemigos: {self combatienteHumanoArthas. self combatienteOrcoOlgra .}.
	
	self combatienteOrcoMankrik atacar.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido.! !


!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'JMB 9/14/2022 22:38:42'!
test29CuandoOlgraEstaDistraidoLeHacen2MasDeDaño
	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas usarEspada.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert 
		isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 12*pv) 
		description: 'Olgra debe tener 12 puntos de vida: 20 (inicial) - 8 (por espada) + 2 (armadura de cuero) - 2 (daño por distraido)'.! !

!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'JMB 9/14/2022 22:40:03'!
test30CuandoElAtaqueNoInflingeDañoOlgraNoRecibeDañoPorEstarDistradido
	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido description: 'Olgra debe tener los puntos de vida completos'.! !

!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'JMB 9/14/2022 22:39:52'!
test31CuandoMankrikEstaDistraidoLeHacen2MasDeDaño
	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	self combatienteHumanoArthas usarEspada.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	Assert 
		isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 12*pv) 
		description: 'Mankrik debe tener 12 puntos de vida: 20 (inicial) - 8 (por espada) + 2 (armadura de cuero) - 2 (daño por distraido)'.! !

!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'JMB 9/14/2022 22:39:39'!
test32CuandoElAtaqueNoInflingeDañoMankrikNoRecibeDañoPorEstarDistradido
	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: self combatienteOrcoMankrik noEstaHerido description: 'Mankrik debe tener los puntos de vida completos'.! !


!CombatientesTest class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 17:41:02'!
arthasConHachaDejaFueraDeCombateAMankrik
	[self combatienteOrcoMankrik estaEnCombate] whileTrue: [self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik]! !

!CombatientesTest class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 17:58:55'!
mankrikConHachaDejaFueraDeCombateAArthas
	[self combatienteHumanoArthas estaEnCombate] whileTrue: [self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas].! !

!CombatientesTest class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 17:53:27'!
olgraConHachaDejaFueraDeCombateAMankrik
	[self combatienteOrcoMankrik estaEnCombate] whileTrue: [self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik]! !


!classDefinition: #Distraido category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #Distraido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distraido class' category: 'AtaquesFantasticosPaso2'!
Distraido class
	instanceVariableNames: 'daño'!

!Distraido class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 19:41:28'!
dañoPorConcentracion
	^daño.! !

!Distraido class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 19:33:19'!
despertarConBofetada
	^Alerta bofetada.
	! !

!Distraido class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:02:53'!
distraerOAlertar: dañoRecibido
 (dañoRecibido > (0 * pv)) ifTrue: [^ self despertarConBofetada].
! !

!Distraido class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:06:26'!
inicial
	daño:= 0 *pv.
	^self.! !


!Distraido class methodsFor: '--** private fileout/in **--' stamp: 'alm 9/18/2022 22:15:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	daño := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'puntosDeVida'; instVarAt: 2 put: 'puntosDeVidas'; instVarAt: 3 put: 'pv'; yourself); yourself).! !


!classDefinition: #EstrategiasTest category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #EstrategiasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstrategiasTest class' category: 'AtaquesFantasticosPaso2'!
EstrategiasTest class
	instanceVariableNames: ''!

!EstrategiasTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:07:54'!
orquestadorParaArthasUsandoUnHachaYConFocoEnElMasHeridoVsOrcos
	
	OrquestadorDeCombatesTest prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self combatienteHumanoArthas usarHacha.
	OrquestadorDeCombatesTest 
		establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ OrquestadorDeCombatesTest orquestadorDeCombates! !

!EstrategiasTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:07:39'!
orquestadorParaArthasUsandoUnHachaYConFocoEnElMasSanoVsOrcos
	
	OrquestadorDeCombatesTest prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self combatienteHumanoArthas usarHacha.
	OrquestadorDeCombatesTest 
		establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ OrquestadorDeCombatesTest orquestadorDeCombates! !

!EstrategiasTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:10:15'!
puntosDeVidaDelGanadorFocalizandoEnElMasHerido
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaArthasUsandoUnHachaYConFocoEnElMasHeridoVsOrcos.
	orquestadorDeCombates desarrollarDuranteRondas: 100.
	^ self combatienteHumanoArthas puntosDeVida! !

!EstrategiasTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:10:08'!
puntosDeVidaDelGanadorFocalizandoEnElMasSano
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaArthasUsandoUnHachaYConFocoEnElMasSanoVsOrcos.
	orquestadorDeCombates desarrollarDuranteRondas: 100.
	^ self combatienteHumanoArthas puntosDeVida! !


!EstrategiasTest class methodsFor: 'combatientes' stamp: 'JMB 9/14/2022 23:10:44'!
combatienteHumanoArthas
	^CombatienteHumanoArthas ! !

!EstrategiasTest class methodsFor: 'combatientes' stamp: 'JMB 9/15/2022 00:01:56'!
combatienteOrcoMankrik
	^CombatienteOrcoMankrik ! !

!EstrategiasTest class methodsFor: 'combatientes' stamp: 'JMB 9/14/2022 23:11:07'!
combatienteOrcoOlgra
	^CombatienteOrcoOlgra ! !


!EstrategiasTest class methodsFor: 'tests' stamp: 'JMB 9/15/2022 00:09:22'!
test01FocalizarEnElMasHeridoEsMejorQueEnElMasSano
	
	Assert isTrue: self puntosDeVidaDelGanadorFocalizandoEnElMasHerido > self puntosDeVidaDelGanadorFocalizandoEnElMasSano.! !


!classDefinition: #OrquestadorDeCombates category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #OrquestadorDeCombates
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeCombates class' category: 'AtaquesFantasticosPaso2'!
OrquestadorDeCombates class
	instanceVariableNames: 'bando1 bando2'!

!OrquestadorDeCombates class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 22:13:11'!
darResultado ": rondaDeFinalizacion" " A refactorizar!! "
	| combatientesVivos1 combatientesVivos2 resultado |
	resultado := 'empate'.
	combatientesVivos1 := (bando1 select: [:combatiente | combatiente estaEnCombate]).
	combatientesVivos2 := (bando2 select: [:combatiente | combatiente estaEnCombate]).
	
	((combatientesVivos1 isEmptyOrNil) and: (combatientesVivos2 isEmptyOrNil)) ifTrue: [resultado := 'empate'].
	((combatientesVivos1 isEmptyOrNil) and: (combatientesVivos2 notEmpty)) 	ifTrue: [resultado := 'ganoBando2'].
	((combatientesVivos2 isEmptyOrNil ) and: (combatientesVivos1 notEmpty)) 	ifTrue: [resultado := 'ganoBando1'].
	
	^resultado.! !

!OrquestadorDeCombates class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 22:14:51'!
desarrollarDuranteRondas: cantidadDeRondas 
	|rondas|
	rondas:= 1.
	[(rondas <= cantidadDeRondas ) "and: (self activo)"] whileTrue: [(bando1 at: 1) atacar. (bando2 at: 1) atacar. rondas:= rondas+1].
	^ self darResultado. ": rondas."! !

!OrquestadorDeCombates class methodsFor: 'as yet unclassified' stamp: 'SM 9/18/2022 20:40:16'!
establecerCombateEntreBando1: unBando1 contraBando2: unBando2
	bando1:= unBando1.
	bando2:= unBando2.
	(bando1 at: 1) enemigos: bando2.
	(bando2 at: 1) enemigos: bando1.
! !


!OrquestadorDeCombates class methodsFor: '--** private fileout/in **--' stamp: 'alm 9/18/2022 22:15:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	bando1 := ((Array new: 1) at: 1 put: CombatienteHumanoArthas; yourself).
	bando2 := ((Array new: 1) at: 1 put: CombatienteOrcoOlgra; yourself).! !


!classDefinition: #OrquestadorDeCombatesTest category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #OrquestadorDeCombatesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeCombatesTest class' category: 'AtaquesFantasticosPaso2'!
OrquestadorDeCombatesTest class
	instanceVariableNames: ''!

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'alm 9/18/2022 21:56:08'!
assertElResultadoIndicaQueGanoElBando1: resultadoDeUnCombate alcanzadaLaRonda: unNumeroDeRondaEsperado

	Assert isTrue: ((resultadoDeUnCombate = 'ganoBando1') and: (resultadoDeUnCombate rondaDeFin = unNumeroDeRondaEsperado )).! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'JMB 9/14/2022 00:30:59'!
assertElResultadoIndicaQueGanoElBando2: resultadoDeUnCombate alcanzadaLaRonda: unNumeroDeRondaEsperado

	Assert isTrue: false description: 'Reemplazar esto por la implementación correspondiente'! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'SM 9/18/2022 20:49:29'!
assertElResultadoIndicaQueNoHayGanador: resultadoDeUnCombate  alcanzadaLaRonda: unNumeroDeRondaEsperado

	Assert isTrue: resultadoDeUnCombate = 'empate' description: 'Reemplazar esto por la implementación correspondiente'.! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'SM 9/18/2022 20:22:07'!
establecerCombateEntreBando1: unBando1 contraBando2: unBando2
	(self orquestadorDeCombates) establecerCombateEntreBando1: unBando1 contraBando2: unBando2.
! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'SM 9/18/2022 20:20:48'!
orquestadorDeCombates

	^OrquestadorDeCombates.! !


!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:30:13'!
orquestadorParaCombateArthasConFocoEnElMasSanoVsOrcos	
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:30:25'!
orquestadorParaCombateArthasInmuneYFocoEnElMasHeridoVsOrcos	
	
	self prepararCombatientes.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas usarArmaduraDeMetal. 
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self establecerCombateEntreBando1:  {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:30:37'!
orquestadorParaCombateArthasVsOlgra	
	
	self prepararCombatientes. 
	self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:30:51'!
orquestadorParaCombateArthasVsOrcos
	self prepararCombatientes.
	self establecerCombateEntreBando1: { self combatienteHumanoArthas } contraBando2: {self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:31:33'!
orquestadorParaCombateManoAManoConBando2Inmune	
	
	self prepararCombatientes.
	self combatienteOrcoOlgra usarEspada.
	self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:31:13'!
orquestadorParaCombateOrcosVsArthas
	self prepararCombatientes.
	self establecerCombateEntreBando1: {self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: { self combatienteHumanoArthas }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:31:43'!
orquestadorParaCombateOrcosVsArthasConFocoEnElMasSano	
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self establecerCombateEntreBando1: { self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: {self combatienteHumanoArthas }. 
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/15/2022 00:31:54'!
orquestadorParaCombateOrcosVsArthasInmuneYFocoEnElMasHerido	
	
	self prepararCombatientes.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas usarArmaduraDeMetal. 
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self establecerCombateEntreBando1: { self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: {self combatienteHumanoArthas }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'JMB 9/12/2022 20:49:44'!
prepararCombatientes

	self combatienteHumanoArthas prepararseParaElCombate. 
	self combatienteOrcoOlgra prepararseParaElCombate.
	self combatienteOrcoMankrik prepararseParaElCombate. ! !


!OrquestadorDeCombatesTest class methodsFor: 'combatientes' stamp: 'JMB 9/12/2022 20:49:23'!
combatienteHumanoArthas

	^ CombatienteHumanoArthas! !

!OrquestadorDeCombatesTest class methodsFor: 'combatientes' stamp: 'JMB 9/12/2022 20:49:44'!
combatienteOrcoMankrik

	^ CombatienteOrcoMankrik! !

!OrquestadorDeCombatesTest class methodsFor: 'combatientes' stamp: 'JMB 9/12/2022 20:48:43'!
combatienteOrcoOlgra

	^ CombatienteOrcoOlgra! !


!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:30:37'!
test01AlDesarrollarUnCombateSinRondasLosCombatientesNoSeAtacan
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 0.
	
	Assert isTrue: self combatienteHumanoArthas noEstaHerido.
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:30:37'!
test02AlDesarrollarUnCombateManoAManoDeUnaRondaLosBandosSeAtacanUnaVez
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 1.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 18*pv) description: 'Arthas debe recibir un puñetazo (2 de daño)'.
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe recibir un puñetazo (2 de daño)'.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:30:37'!
test03AlDesarrollarUnCombateManoAManoConMasDeUnaRondaLosBandosSeAtacanCadaVez
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 16*pv) description: 'Arthas debe recibir dos puñetazos (4 de daño)'.
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe recibir dos puñetazos (4 de daño)'.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:30:37'!
test04AlDesarrollarUnCombateManoAManoSinGanadoresElResultadoEsIndeterminado
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 0.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 0.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:30:37'!
test05AlDesarrollarUnCombateManoAManoGanaElBando1CuandoDejaFueraDeCombateASuRival
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:30:37'!
test06AlDesarrollarUnCombateCuandoHayUnGanadorFinalizaEnLaRondaQueElPerdedorQuedoFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 11.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'JMB 9/15/2022 00:31:33'!
test07AlDesarrollarUnCombateManoAManoGanaElBando2CuandoDejaFueraDeCombateASuRival
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateManoAManoConBando2Inmune.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 100.
	
	self assertElResultadoIndicaQueGanoElBando2: resultado alcanzadaLaRonda: 3.! !


!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'JMB 9/15/2022 00:30:13'!
test08AlDesarrollarUnCombateLosDelBando1PuedenAtacarACualquieraDelBando2
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasConFocoEnElMasSanoVsOrcos.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido. 
	Assert isTrue: self combatienteOrcoMankrik estaHerido. ! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'JMB 9/15/2022 00:31:13'!
test09AlDesarrollarUnCombateAtacanTodesLosDelBando1EnCadaRonda
	"
		En cada ronda Olgra daña a Arthas en 2  (2 puños + 1 por fuerza - 1 por agilidad de Arthas) y  Mankrik 3 (2 puños + 2 por fuerza - 1 por agilidad de Arthas) 
	"
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthas.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 4.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 4.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'JMB 9/15/2022 00:31:43'!
test10AlDesarrollarUnCombateLosDelBando2PuedenAtacarACualquieraDelBando1
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthasConFocoEnElMasSano.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido. 
	Assert isTrue: self combatienteOrcoMankrik estaHerido. ! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'JMB 9/15/2022 00:30:51'!
test11AlDesarrollarUnCombateAtacanTodesLosDelBando2EnCadaRonda
	"
		En cada ronda Olgra daña a Arthas en 2  (2 puños + 1 por fuerza - 1 por agilidad de Arthas) y  Mankrik 3 (2 puños + 2 por fuerza - 1 por agilidad de Arthas) 
	"
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOrcos.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 4.
	
	self assertElResultadoIndicaQueGanoElBando2: resultado alcanzadaLaRonda: 4.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'JMB 9/15/2022 00:30:25'!
test12AlDesarrollarUnCombateLosDelBando1NoGananSiTodosLosDelBando2NoEstanFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasInmuneYFocoEnElMasHeridoVsOrcos.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'JMB 9/15/2022 00:31:54'!
test13AlDesarrollarUnCombateLosDelBando2NoGananSiTodosLosDelBando1NoEstanFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthasInmuneYFocoEnElMasHerido.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 10.! !


!classDefinition: #Resultado category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #Resultado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Resultado class' category: 'AtaquesFantasticosPaso2'!
Resultado class
	instanceVariableNames: ''!

!Resultado class methodsFor: 'as yet unclassified' stamp: 'alm 9/18/2022 21:57:45'!
rondaDeFin
	^5! !

Alerta initializeAfterFileIn!
CombatienteHumanoArthas initializeAfterFileIn!
CombatienteOrcoMankrik initializeAfterFileIn!
CombatienteOrcoOlgra initializeAfterFileIn!
CombatientesTest initialize!
Distraido initializeAfterFileIn!
OrquestadorDeCombates initializeAfterFileIn!