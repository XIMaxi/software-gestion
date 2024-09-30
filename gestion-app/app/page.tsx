import Image from 'next/image';
import styles from './styles/Main.module.css';

// Convertimos la función a async para futuras operaciones asíncronas
export default async function main() {
  // Aquí podrías agregar una llamada asíncrona si es necesario en el futuro, como fetch a una API
  // const data = await fetchData();

  return (
    <div className={styles.container}>
      {/* Barra de Título */}
      <div className={styles.titleBar}>
        <h1>Gestión ICOC</h1>
      </div>

      {/* Logo */}
      <div className={styles.logo}>
        <Image
          src="/img/LOGOICOC.png"
          alt="Logo"
          width={1000}
          height={500}
          className={styles.logoImage}
        />
      </div>
    </div>
  );
}