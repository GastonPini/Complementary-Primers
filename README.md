# Complementary Primers

## This script designs PCR primers.
    
A primer is a synthetic oligonucleotide which is mainly used in PCR (Polymerase Chain Reaction), for the amplification of a DNA fragment. The primers must have a sequence which must be reverse complementary to a region of the target or template DNA, so that the annealing can be carried out.


## Usage

### Input:
- File containing a nucleotide sequence.
- Beggining and ending positions in the sequence of interest for the primer creation.

### Output:
- Sequence of interest and its length.
- Sequence of the forward primer.
- GC% content of the forward primer.


## Primer length
A primer must be complex enough such that the probability of annealing with a sequence other than the one of interest is very low. It is highly recommended that a primer be at least 17 bases long.

## General tips for primer design:

1. Primers should be 17-28 bases in length.
2. The content of G+C should be around 50-60%.
4. Sequences of 3 or more Cs or Gs in the 3' terminal regions should be avoided.
5. The 3' ends must not be complementary, as this can lead to dimer formation.
6. Primers that form self-complementary sequences should be avoided.