#let c_thm = counter("theorem")
#let c_lem = counter("lemma")
#let c_cor = counter("corollary")
#let c_def = counter("definition")
#let c_rmk = counter("remark")
#let c_xmp = counter("example")
#let c_list = (c_thm, c_lem, c_cor, c_def)
#let kind_list = ("theorem", "lemma", "corollary", "definition", "remark", "example")

#let parvirtual = {
"" 
context v(-par.spacing -  measure("").height)
}

#let thm_num(level: 1) = {
  (..nums) => {
    if level == 0 {
      return ""
    } else {
      let l = nums.pos()
      if l.len() > level{
        l = l.slice(0,level)
      } else {
        while l.len() < level {
          l.push(0)
        }
      }
      return l.map(str).join(".") + "."
    }
  }
}

#let theorem(body, name: none, kind: "theorem", type: "Theorem", count: c_thm, indent: none, level: 1) = {
  let numbering = thm_num(level: level)
  let headnumber = context counter(heading).get().at(0)
  let thmnumber = context count.get().at(0)
  return (figure({
    count.step()
    block[
    #if indent != none {
    parvirtual
    }
    #if name == none {[
      // *#type #headnumber.#thmnumber.*#h(0.4em)
      *#type #context counter(heading).display(numbering)#thmnumber.*#h(0.4em)
    ]} else {[
      *#type #context counter(heading).display(numbering)#thmnumber* (#name)*.*#h(0.4em)
    ]}
    #body]
  }, kind: kind, supplement: type))
}
  
  
#let remark(body, name: none, kind: "remark", type: "Remark", count: c_rmk, indent: none) = {
  // return (body, headnumber, thmnumber) => {
    return (figure({
      count.step()
      block[
      #if indent != none {
      parvirtual
      }
      #if name == none {[
        *#type.*#h(0.4em)
      ]} else {[
        *#type.*
      ]}
      #body]
    }, kind: kind, supplement: type))
  // }
}


#let lemma = theorem.with(kind: "lemma", type: "Lemma", count: c_lem)
#let corollary = theorem.with(kind: "corollary", type: "Corollary", count: c_cor)
#let definition = theorem.with(kind: "definition", type: "Definition", count: c_def)

#let example = remark.with(kind: "example", type: "Example", count: c_xmp)

#let proof(body, type: "Proof", count: c_thm, indent: none) = {
  v(2em, weak: true)
  block[
  #if indent != none {
  parvirtual
  }
  _#type._
  #body 
  #box(width: 2em)
  #h(1fr)
  $qed$
  ]
  parvirtual
  v(2em, weak: true)
}


#let dingli = theorem.with(type: "定理", count: c_thm, indent: true)
#let yinli = lemma.with(type: "引理", indent: true)
#let tuilun = corollary.with(type: "推论", indent: true)
#let dingyi = definition.with(type: "定义", indent: true)

#let lizi = example.with(type: "例")

#let zhengming = proof.with(type: "证明", indent: true)


#let dingli-rules(doc, level: 1, upper: 2em, lower: 2em) = {
  show heading: it => {
    if it.level <= level {
      for c in c_list {
        c.update(0)
      }
      for k in kind_list {
        counter(figure.where(kind: k)).update(0)
      }
    }
    it
  } 
  show figure: it => {
    if it.kind in kind_list {
      v(upper, weak: true)
      set align(start)
      set block(breakable: true)
      it
      parvirtual
      v(lower, weak: true)
    } else {
      it
    }
  }
  show ref: it => {
    if it.element == none{
      it
    } else if it.element.func() == figure and it.element.kind in kind_list{
      link(
        it.element.location()
      )[#it.element.supplement #thm_num(level: level)(..counter(heading).at(it.element.location()))#counter(figure.where(kind: it.element.kind)).at(it.element.location()).at(0)]
    } else {
      it
    }
  }
  doc
}