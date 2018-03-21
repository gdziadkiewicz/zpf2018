(** This first serie of  exercises asks you to prove some derived
    inference rule. For some of them, build a small example of its application. 


First, let us look at some example : *)

Lemma P3Q : forall P Q : Prop, (((P->Q)->Q)->Q) -> P -> Q.
Proof.
 intros P Q H p; apply H. 
 intro H0;apply H0;assumption. 
Qed.

Lemma triple_neg : forall P:Prop, ~~~P -> ~P.
Proof.
 intros P ;unfold not; apply P3Q.
Qed.


Lemma all_perm :
 forall (A:Type) (P:A -> A -> Prop),
   (forall x y:A, P x y) -> 
   forall x y:A, P y x.
Proof.
intros.
apply H.
Qed.


Lemma resolution :
 forall (A:Type) (P Q R S:A -> Prop),
   (forall a:A, Q a -> R a -> S a) ->
   (forall b:A, P b -> Q b) -> 
   forall c:A, P c -> R c -> S c.
Proof.
intros.
apply H.
* apply H0.
  assumption.
* assumption.
Qed.


Lemma not_ex_forall_not : forall (A: Type) (P: A -> Prop),
                      ~(exists x, P x) <-> forall x, ~ P x.
Proof.
unfold not.
intros.
split.
* intros.
  apply H.
  exists x.
  assumption.
* intros.
  destruct H0.
  assert (P x -> False).
  + apply H.
  + apply H1.
    assumption.
Qed.

Lemma ex_not_forall_not : forall (A: Type) (P: A -> Prop),
                       (exists x, P x) -> ~ (forall x, ~ P x).
Proof.
unfold not.
intros.
destruct H.
assert (P x -> False).
* apply H0.
* apply H1.
apply H.
Qed.

Lemma diff_sym : forall (A:Type) (a b : A), a <> b -> b <> a.
Proof.
unfold not.
intros.
apply H.
congruence.
Qed.

Lemma fun_diff :  forall (A B:Type) (f : A -> B) (a b : A), 
                       f a <> f b -> a <> b.
Proof.
unfold not.
intros.
apply H.
congruence.
Qed.

Section On_functions.
Variables (U V W : Type).

Variable g : V -> W.
Variable f : U -> V.

 Definition injective : Prop := forall x y:U, f x = f y -> x = y.
 Definition surjective : Prop := forall v : V, exists u:U, f u = v.

Lemma injective' : injective -> forall x y:U, x <> y -> f x <> f y.
Proof.
unfold injective.
unfold not.
intros.
apply H0.
apply H.
assumption.
Qed.

 Definition compose := fun u : U => g (f u).

End On_functions.
Arguments compose [U V W].
Arguments injective [U V].
Arguments surjective [U V].

Lemma injective_comp : forall U V W (f:U->V)(g : V -> W),
                       injective (compose g f) -> injective f.
Proof.
unfold compose.
unfold injective.
intros.
apply H.
congruence.
Qed.

Lemma surjective_comp : forall U V W (f:U->V)(g : V -> W),
                       surjective (compose g f) -> surjective g.
Proof.
unfold surjective.
unfold compose.
intros.
assert (exists u : U, g (f u) = v).
* apply H.
* destruct H0.
  exists (f x).
  assumption.
Qed.

Lemma comp_injective : forall U V W (f:U->V)(g : V -> W),
                       injective f -> injective g -> injective (compose g f).
Proof.
unfold injective.
unfold compose.
intros.
apply H.
apply H0.
assumption.
Qed.

Fixpoint iterate (A:Type)(f:A->A)(n:nat) {struct n} : A -> A :=
 match n with 0 => (fun a => a)
            | S p => fun a => f (iterate _ f p a) 
 end.

 Lemma iterate_inj : forall U (f:U->U) , 
                      injective f ->
                      forall n: nat, injective   (iterate _ f n).
Proof.
 unfold injective.
 induction n;simpl.
 * intros;assumption.
 * intros. 
   apply IHn.
   apply H.
   assumption.
Qed.
 


 




 

 

                         
  
