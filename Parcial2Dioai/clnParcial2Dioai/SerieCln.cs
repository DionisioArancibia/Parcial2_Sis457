using CadParcial2Dioai;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace clnParcial2Dioai
{
    public class SerieCln
    {
        public static int insertar(Serie serie)
        {
            using (var context = new Parcial2DioaiEntities())
            {
                context.Series.Add(serie);
                context.SaveChanges();
                return serie.id;
            }
        }

        public static int actualizar(Serie serie)
        {
            using (var context = new Parcial2DioaiEntities())
            {
                var existente = context.Series.Find(serie.id);
                existente.titulo = serie.titulo;
                existente.sinopsis = serie.sinopsis;
                existente.director = serie.director;
                existente.episodios = serie.episodios;
                existente.fechaEstreno = serie.fechaEstreno;
                existente.idiomaPrincipal = serie.idiomaPrincipal;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id)
        {
            using (var context = new Parcial2DioaiEntities())
            {
                var serie = context.Series.Find(id);
                serie.estado = -1;
                return context.SaveChanges();
            }
        }

        public static Serie obtenerUno(int id)
        {
            using (var context = new Parcial2DioaiEntities())
            {
                return context.Series.Find(id);
            }
        }

        public static List<Serie> listar()
        {
            using (var context = new Parcial2DioaiEntities())
            {
                return context.Series.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paSerieListar_Result> listarPa(string parametro)
        {
            using (var context = new Parcial2DioaiEntities())
            {
                return context.paSerieListar(parametro).ToList();
            }
        }
    }
}

