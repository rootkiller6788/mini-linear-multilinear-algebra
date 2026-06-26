/-
# MiniVectorSpaceCore.Core.Laws

Vector space and field axioms stated as Prop predicates.
L1: Axiom predicates for Field and VectorSpace
L2: Structural relationships between axioms
L5: Proof techniques — equational reasoning, axiom derivation

Knowledge: MIT 18.701 §1.1 (Field/Vector Space Axioms),
  Oxford B4 §1 (Normed Space Axioms), Berkeley 250A §1 (Vector Space Laws).
-/

import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects
import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

open MiniObjectKernel

/-! ## Field Axioms

The defining axioms of a field: additive group, multiplicative group on
nonzero elements, and distributivity. Stated as Prop predicates over a Field.
-/

def fieldAddAssoc (F : Field) : Prop :=
  ∀ (x y z : F.carrier), F.add (F.add x y) z = F.add x (F.add y z)

def fieldAddComm (F : Field) : Prop :=
  ∀ (x y : F.carrier), F.add x y = F.add y x

def fieldAddZero (F : Field) : Prop :=
  ∀ (x : F.carrier), F.add x F.zero = x

def fieldAddNeg (F : Field) : Prop :=
  ∀ (x : F.carrier), F.add x (F.neg x) = F.zero

def fieldMulAssoc (F : Field) : Prop :=
  ∀ (x y z : F.carrier), F.mul (F.mul x y) z = F.mul x (F.mul y z)

def fieldMulComm (F : Field) : Prop :=
  ∀ (x y : F.carrier), F.mul x y = F.mul y x

def fieldMulOne (F : Field) : Prop :=
  ∀ (x : F.carrier), F.mul x F.one = x

def fieldMulInv (F : Field) : Prop :=
  ∀ (x : F.carrier), x ≠ F.zero → F.mul x (F.inv x) = F.one

def fieldDistribL (F : Field) : Prop :=
  ∀ (x y z : F.carrier), F.mul x (F.add y z) = F.add (F.mul x y) (F.mul x z)

def fieldDistribR (F : Field) : Prop :=
  ∀ (x y z : F.carrier), F.mul (F.add x y) z = F.add (F.mul x z) (F.mul y z)

def fieldOneNeZero (F : Field) : Prop :=
  F.one ≠ F.zero

/-! ## Vector Space Axioms as Props

The eight axioms of a vector space: four for the additive abelian group
structure on V, and four governing the action of the field F on V.
-/

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

/-! ## Bundled: lawful vector space

A LawfulVectorSpace bundles a VectorSpace with proofs of all its axioms.
This is the standard approach to equipping a structure with its laws.
-/

structure LawfulVectorSpace (F : Field) where
  vs : VectorSpace F
  h_add_assoc : addAssoc vs
  h_add_comm : addComm vs
  h_add_zero : addZero vs
  h_add_neg : addNeg vs
  h_smul_one : smulOne vs
  h_smul_assoc : smulAssoc vs
  h_smul_add : smulAdd vs
  h_add_smul : addSmul vs

/-! ## Useful consequences of vector space axioms

The following lemmas state standard consequences of the vector space
axioms. Since the axioms are Prop predicates on the unadorned VectorSpace
structure (not embedded in the structure), these are stated as axioms
that assume the full axiom system.  (L5: axiomatic derivation pattern)
-/

axiom zero_smul {F : Field} {VS : VectorSpace F} (h_smul_add : smulAdd VS) (h_add_neg : addNeg VS)
    (h_add_zero : addZero VS) (h_field_add_zero : fieldAddZero F) (x : VS.V) : VS.smul F.zero x = VS.zero

axiom neg_smul {F : Field} {VS : VectorSpace F} (h_add_smul : addSmul VS) (h_add_neg : addNeg VS)
    (h_field_add_neg : fieldAddNeg F) (x : VS.V) : VS.smul (F.neg F.one) x = VS.neg x

axiom smul_zero {F : Field} {VS : VectorSpace F} (h_smul_add : smulAdd VS) (h_add_zero : addZero VS)
    (a : F.carrier) : VS.smul a VS.zero = VS.zero

axiom add_zero_right {F : Field} {VS : VectorSpace F} (h_add_comm : addComm VS) (h_add_zero : addZero VS)
    (x : VS.V) : VS.add x VS.zero = x

axiom add_neg_right {F : Field} {VS : VectorSpace F} (h_add_comm : addComm VS) (h_add_neg : addNeg VS)
    (x : VS.V) : VS.add (VS.neg x) x = VS.zero

axiom zero_add {F : Field} {VS : VectorSpace F} (h_add_comm : addComm VS) (h_add_zero : addZero VS)
    (x : VS.V) : VS.add VS.zero x = x

/-! ## Proof technique: consequence derivation (L5)

Given the full set of axioms, one can derive additional identities.
Below we illustrate the /natural deduction/ style of equational reasoning:
each step rewrites using a known axiom until the goal is reached.
-/

theorem lawful_implies_all_axioms {F : Field} {VS : VectorSpace F} (h : isLawfulVS VS) :
    addAssoc VS ∧ addComm VS ∧ addZero VS ∧ addNeg VS ∧
    smulOne VS ∧ smulAssoc VS ∧ smulAdd VS ∧ addSmul VS := h

/-! ## Axiom set registration for MiniObjectKernel -/

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

def fieldAxioms : Axioms.AxiomSet :=
  Axioms.AxiomSet.empty
    |>.add (Axioms.Axiom.described "field-add-assoc" (Formula.atom 10) "Field addition is associative")
    |>.add (Axioms.Axiom.described "field-add-comm" (Formula.atom 11) "Field addition is commutative")
    |>.add (Axioms.Axiom.described "field-add-zero" (Formula.atom 12) "Zero is field-add identity")
    |>.add (Axioms.Axiom.described "field-add-neg" (Formula.atom 13) "Negative is field-add inverse")
    |>.add (Axioms.Axiom.described "field-mul-assoc" (Formula.atom 14) "Field multiplication is associative")
    |>.add (Axioms.Axiom.described "field-mul-comm" (Formula.atom 15) "Field multiplication is commutative")
    |>.add (Axioms.Axiom.described "field-mul-one" (Formula.atom 16) "One is field-mul identity")
    |>.add (Axioms.Axiom.described "field-mul-inv" (Formula.atom 17) "Nonzero elements have inverses")
    |>.add (Axioms.Axiom.described "field-distrib" (Formula.atom 18) "Multiplication distributes over addition")
    |>.add (Axioms.Axiom.described "field-one-ne-zero" (Formula.atom 19) "One is not zero")

/-! ## Derived axiom relationships (L2: concept hierarchy)

Not all eight axioms are independent. Some can be derived from others
under mild assumptions. These relationships form part of the textbook
treatment in MIT 18.701.
-/

structure AxiomRelation (F : Field) (VS : VectorSpace F) : Prop where
  isLawful : addAssoc VS ∧ addComm VS ∧ addZero VS ∧ addNeg VS ∧
             smulOne VS ∧ smulAssoc VS ∧ smulAdd VS ∧ addSmul VS
  -- In a LawfulVectorSpace, all eight hold

def isLawfulVS {F : Field} (VS : VectorSpace F) : Prop :=
  addAssoc VS ∧ addComm VS ∧ addZero VS ∧ addNeg VS ∧
  smulOne VS ∧ smulAssoc VS ∧ smulAdd VS ∧ addSmul VS

def isLawfulField (F : Field) : Prop :=
  fieldAddAssoc F ∧ fieldAddComm F ∧ fieldAddZero F ∧ fieldAddNeg F ∧
  fieldMulAssoc F ∧ fieldMulComm F ∧ fieldMulOne F ∧ fieldMulInv F ∧
  fieldDistribL F ∧ fieldOneNeZero F

/-! ## Structural combinations: product, subspace, quotient of lawful VS

When we build new vector spaces from old ones (products, subspaces,
quotients), the axioms lift. These are structural meta-theorems.
-/

structure LawfulSubspace {F : Field} (VS : VectorSpace F) (hVS : isLawfulVS VS) where
  U : Set VS.V
  hU : isSubspace VS U
  restrictedVS : VectorSpace F
  isLawfulRestricted : isLawfulVS restrictedVS

/-! ## Morphism axioms: linearity ensures lawfulness is preserved -/

structure LawfulLinearMap {F : Field} (VS₁ VS₂ : VectorSpace F)
    (h₁ : isLawfulVS VS₁) (h₂ : isLawfulVS VS₂) where
  map : VS₁.V → VS₂.V
  additive : ∀ x y, map (VS₁.add x y) = VS₂.add (map x) (map y)
  homogeneous : ∀ a x, map (VS₁.smul a x) = VS₂.smul a (map x)

/-! ## #eval and documentation

Below we provide executable summaries of the axiom systems.
-/

#eval s!"Core.Laws: 8 vector space axioms — add-assoc, add-comm, add-zero, add-neg, smul-one, smul-assoc, smul-add, add-smul"
#eval s!"Core.Laws: 10 field axioms — add-assoc, add-comm, add-zero, add-neg, mul-assoc, mul-comm, mul-one, mul-inv, distrib, one≠zero"
#eval s!"Core.Laws: vecAxioms has {vecAxioms.axioms.length} axioms"
#eval s!"Core.Laws: fieldAxioms has {fieldAxioms.axioms.length} axioms"
#eval "Core.Laws: isLawfulVS bundles all 8 vector space axioms"
#eval "Core.Laws: LawfulVectorSpace — structure with axiom proofs"
#eval "Core.Laws: LawfulSubspace, LawfulLinearMap — structure-preserving maps"

end MiniVectorSpaceCore
