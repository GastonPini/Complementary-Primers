#!/usr/bin/perl

print "Ingresar el archivo de texto con la secuencia completa que contiene el target de inters solamente con los nucleótidos: ";
my $archivo = <STDIN>;	chomp $archivo;
unless (open (FILEIN, $archivo) ) {
	print "No se puede abrir el archivo $archivo\n\n";
	exit;
}

@array = <FILEIN>;
close(FILEIN);
$adn;
$bul = 0;

foreach my $line (@array){ 
	chomp($line);
	$adn = $adn . $line; 
} 

$pero = 0;
$aviso = 0;
$d = 0;
$c = 0;
print "Ingrese el rango de la temperatura de melting, [0,0] por default:\n";
$T_min = <STDIN>;
$T_max = <STDIN>;
if($T_min == 0){
	if($T_max == 0){
		$T_min = 50;
		$T_max = 60;
	}
}
print "Ingresar la posiciones de inicio y final de la secuencia de inters: \n";
$inicio = <STDIN>;
$fin = <STDIN>;

while($bul == 0 & length($adn) > 200){
	$af = 0; $cf = 0; $gf = 0; $tf = 0;
	$ar = 0; $cr = 0; $gr = 0; $tr = 0;
	
	while($pero == 0){
		
		if ($d == 10){
			$inicio--;
			$d = 0;
		}

		if ($inicio > 28){
			$forward =  substr($adn, $inicio - 18 - $d, 17 + $d);
			while($forward =~ /A/ig){$af++;}
			while($forward =~ /T/ig){$tf++;}
			while($forward =~ /C/ig){$cf++;}
			while($forward =~ /G/ig){$gf++;}
			
			$tam_primer_f = $af + $cf + $gf + $tf;
			$T_f = 4*($cf + $gf) + 2*($af + $tf)*$cf;
			
			if($T_f >= $T_max or $T_f <= $T_min){
				$pero = 0;
			}
			$por_gc_f = 100*($cf + $gf) / $tam_primer_f;
			if($por_gc_f >= 30 and $por_gc_f <= 70){
				$pero = 1;
			}			
			$a = substr($forward, length($forward)*2 / 3, length($forward)*1 / 3);
			if($a =~ /(C|G){3}/ig){
				$pero = 0;
			}
			
			if($pero == 0){
				$d++;
			}
		}
		else{
			if ($inicio >= 0){
				print"No se encuentra un reverse. Ingrese otra posición, o 0 para salir: ";
				$inicio = <STDIN>;
				$d = 0;
				if($inicio == 0){
					exit;
				}
			}
		}
		$af = 0; $cf = 0; $gf = 0; $tf = 0; 
	}
	print "La posición de inicio del forward es $inicio.\n\n\n";
	

	while($aviso == 0){
		if ($c == 10){
			$fin++;
			$c = 0;
		}
		if( (length($adn) - $fin) > 28){
			$reverse = substr($adn, $fin,17+$c);
			$reverse =~ tr/GATC/CTAG/;
			while($reverse =~ /A/ig){$ar++;}
			while($reverse =~ /T/ig){$tr++;}
			while($reverse =~ /C/ig){$cr++;}
			while($reverse =~ /G/ig){$gr++;}
			$tam_primer_r = $ar + $cr + $gr + $tr;
			$por_gc_r = 100*($cr + $gr) / $tam_primer_r;
			if($por_gc_r >= 50 & $por_gc_r <= 70){
				$aviso = 1;
			}
			$b = substr($reverse, length($reverse)*2/3,length($reverse)*1/3);
			if($b =~ /(C|G){3}/ig){
				$aviso = 0;
			}
			$T_r = 4*($cr + $gr) + 2*($ar + $tr)*$cr;
			if($T_r >= $T_max or $T_r <= $T_min){
				$aviso = 0;
			}
			if($aviso == 0){
				$c++;
			}
		}
		else{
			if (length($adn) - $fin <= 28 and length($adn) - $fin >= 0){
				print"No se encuentra un reverse. Ingrese otra posición, o 0 para salir: ";
				$fin = <STDIN>;
				$d = 0;
				if($fin == 0){
					exit;
				}
			}
		}
		$ar = 0; $cr = 0; $gr = 0; $tr = 0; 
	}
	print "La posición de inicio del reverse es $fin.\n\n\n";
	
	if(($T_f - $T_r) <= 5 & ($T_f - $T_r) >= -5){
		$bul = 1;
	}
	else{
		print"delta TM mayor a 5C.\n\n";
		if(length($forward) > length($reverse)){
			$c++;
			$aviso = 0;
		}
		else{
			if(length($forward) < length($reverse)){
				$d++;
				$aviso = 0;
			}
			else{
				if((length($adn) - fin - $c) > ($inicio - 17 - $d)){
					$aviso = 0;
				}
				else{
					$pero = 0;
				}
			}
		}
	}
}

$secuencia = substr($adn, $inicio, $fin - $inicio);
print"Secuencia de inters:\n$secuencia";

print "Longitud del primer forward: $tam_primer_f. \n\n";
print "Longitud del primer reverse: $tam_primer_r. \n\n";

print "Primer forward: $forward. \n\n";
print "Primer reverse: $reverse. \n\n";

print "Porcentaje GC en forward: $por_gc_f. \n\n";
print "Porcentaje GC en reverse: $por_gc_r. \n\n";

print "Temperatura de melting de forward: $T_f. \n\n";
print "Temperatura de melting de reverse: $T_r. \n\n";

$dif = $T_f - $T_r;

print "Diferencia entre temperaturas de melting: $dif.";
