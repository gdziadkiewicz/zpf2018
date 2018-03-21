
(*
Prove these tautologies of propositional logic, 
using only the tactics apply, assumption, constructor, 
destruct, intro, intros, left, right, split, and unfold.
*)

Lemma P: (True \/ False) /\ (False \/ True).
Proof.
split.
* left.
constructor.
* right.
constructor.
Qed.

Lemma D: forall P:Prop, P -> ~ ~ P.
Proof.
intros.
unfold not.
intros.
apply H0.
assumption.
Qed.

Lemma Trzeci: forall P Q R: Prop, P /\ (Q \/ R) -> (P /\ Q) \/ (P /\ R).
Proof.
intros.
destruct H.
destruct H0.
* left;split;assumption.
* right;split;assumption.
Qed.

Section FirstOrder.

Parameter T:Type.

Parameter p: T -> Prop.

Parameter q: T -> T -> Prop.

Parameter a: T.

Parameter f: T -> T.

(*You may use assert*)
  
Lemma C: (p a) -> (forall x, p x -> exists y, q x y) -> 
                (forall x y, q x y -> q y (f y)) -> exists z, q z (f z). 
Proof.
intros.
assert (exists y : T, q a y).
* apply H0;assumption.
* destruct H2.
  exists x.
  assert (forall y : T, q a y -> q y (f y)).
  + apply H1.
  + apply H3.
    assumption.
Qed.

End FirstOrder.  
