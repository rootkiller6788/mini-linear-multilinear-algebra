import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects
import MiniVectorSpaceCore.Core.Basic

namespace MiniVectorSpaceCore

open MiniObjectKernel

/-! ## Vector Space Axioms as Props -/

def addAssoc {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (x y z : VS.V), VS.add (VS.add x y) z = VS.add x (VS.add y z)

def addComm {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (x y : VS.V), VS.add x y = VS.add y x

def addZero {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (x : VS.V), VS.add x VS.zero = x

def addNeg {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (x : VS.V), VS.add x (VS.neg x) = VS.zero

def smulOne {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (x : VS.V), VS.smul F.one x = x

def smulAssoc {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (a b : F.carrier) (x : VS.V), VS.smul (F.mul a b) x = VS.smul a (VS.smul b x)

def smulAdd {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (a : F.carrier) (x y : VS.V), VS.smul a (VS.add x y) = VS.add (VS.smul a x) (VS.smul a y)

def addSmul {F : Field} (VS : VectorSpace F) : Prop :=
  ∀ (a b : F.carrier) (x : VS.V), VS.smul (F.add a b) x = VS.add (VS.smul a x) (VS.smul b x)

def vecAxioms : Axioms.AxiomSet :=
  Axioms.AxiomSet.empty
    |>.add (Axioms.Axiom.described "add-assoc" (Formula.atom 0) "Addition is associative")
    |>.add (Axioms.Axiom.described "add-comm" (Formula.atom 1) "Addition is commutative")
    |>.add (Axioms.Axiom.described "add-zero" (Formula.atom 2) "Zero is identity")
    |>.add (Axioms.Axiom.described "add-neg" (Formula.atom 3) "Negative is inverse")
    |>.add (Axioms.Axiom.described "smul-one" (Formula.atom 4) "1 · x = x")
    |>.add (Axioms.Axiom.described "smul-assoc" (Formula.atom 5) "a(bx) = (ab)x")
    |>.add (Axioms.Axiom.described "smul-add" (Formula.atom 6) "a(x+y) = ax+ay")
    |>.add (Axioms.Axiom.described "add-smul" (Formula.atom 7) "(a+b)x = ax+bx")

#eval s!"Core.Laws: {vecAxioms.axioms.length} vector space axioms"
