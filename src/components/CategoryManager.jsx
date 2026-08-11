import { useState } from 'react'
import { Plus, Trash2 } from 'lucide-react'
import { supabase } from '../lib/supabase'

const slugify = value => value.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')

export default function CategoryManager({ categories, onChanged, onNotice }) {
  const [name, setName] = useState('')
  const [busy, setBusy] = useState(false)

  const create = async event => {
    event.preventDefault()
    if (!name.trim()) return
    setBusy(true)
    const { error } = await supabase.from('categories').insert({ name: name.trim(), slug: slugify(name) })
    onNotice(error ? error.message : 'Categoría creada correctamente.')
    if (!error) { setName(''); onChanged() }
    setBusy(false)
  }

  const remove = async category => {
    if (!confirm(`¿Eliminar la categoría ${category.name}? Los productos quedarán sin categoría.`)) return
    const { error } = await supabase.from('categories').delete().eq('id', category.id)
    onNotice(error ? error.message : 'Categoría eliminada.')
    if (!error) onChanged()
  }

  return <section style={{margin:'20px max(4vw, 30px)',background:'#fff',border:'1px solid #dfe4df',padding:20}}>
    <div style={{display:'flex',gap:16,alignItems:'end',justifyContent:'space-between',flexWrap:'wrap'}}>
      <div><small style={{color:'#a76a00',letterSpacing:2}}>ORGANIZACIÓN</small><h2 style={{fontSize:32,color:'#17382f'}}>Categorías</h2></div>
      <form onSubmit={create} style={{display:'flex',gap:8,flex:'1 1 320px',maxWidth:520}}>
        <input aria-label="Nombre de categoría" placeholder="Nueva categoría" value={name} onChange={e=>setName(e.target.value)} />
        <button className="btn primary" disabled={busy}><Plus /> Agregar</button>
      </form>
    </div>
    <div style={{display:'flex',flexWrap:'wrap',gap:8,marginTop:18}}>{categories.map(category=><span key={category.id} style={{display:'inline-flex',alignItems:'center',gap:8,padding:'8px 10px',background:'#f5f6f4',fontSize:12}}>{category.name}<button type="button" aria-label={`Eliminar ${category.name}`} onClick={()=>remove(category)} style={{border:0,background:'none',color:'#bd3e35',display:'grid',placeItems:'center'}}><Trash2 size={14}/></button></span>)}</div>
  </section>
}
