import axios, { AxiosResponse } from 'axios';
import cheerio from 'cheerio';

async function getPalabra(req: any, res: any) {
    const palabra = req.params.palabra;
    const userAgent = 'Mozilla/5.0'; // Define tu User-Agent aquí
    console.log("Se buscó: " + palabra);

    try {
        // Realiza una solicitud GET a la URL de la RAE con el User-Agent definido
        const response: AxiosResponse = await axios.get('https://dle.rae.es/' + palabra, {
            headers: {
                'User-Agent': userAgent
            }
        });

        // Verifica si la solicitud fue exitosa
        if (response.status !== 200) {
            throw new Error('La solicitud a la RAE no fue exitosa');
        }

        // Carga el HTML en Cheerio
        const $ = cheerio.load(response.data);

        // Imprime el HTML de la página para depuración
        console.log($.html());

        // Intenta extraer el texto de la definición
        const definicion = $('section p').text().trim();

        // Devuelve la definición como JSON
        res.json({ palabra, definicion });
    } catch (error) {
        // Manejo de errores
        console.error('Error:', error);
        res.status(500).json({ error: 'Hubo un error al procesar la solicitud.' });
    }
}

export default getPalabra;
