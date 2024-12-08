import 'package:flutter/material.dart';

void main() {
  runApp(const CardapioApp());
}

class CardapioApp extends StatelessWidget {
  const CardapioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const CardapioScreen(),
    );
  }
}

class CardapioScreen extends StatefulWidget {
  const CardapioScreen({super.key});

  @override
  State<CardapioScreen> createState() => _CardapioScreenState();
}

class _CardapioScreenState extends State<CardapioScreen> {
  final List<Map<String, dynamic>> cardapios = [
    {
      "nome": "Prato do Dia",
      "tipo": "Principal",
      "ingredientes": ["arroz", "feijão", "frango grelhado"],
      "preco": 15.99
    },
    {
      "nome": "Salada Caesar",
      "tipo": "Entrada",
      "ingredientes": ["alface", "frango grelhado", "queijo parmesão", "croutons"],
      "preco": 12.50
    },
    {
      "nome": "Sopa do Dia",
      "tipo": "Entrada",
      "ingredientes": ["vegetais", "caldo de galinha"],
      "preco": 8.00
    },
    {
      "nome": "Espaguete à Carbonara",
      "tipo": "Prato Principal",
      "ingredientes": ["espaguete", "bacon", "ovos", "queijo parmesão"],
      "preco": 18.75
    },
    {
      "nome": "Pizza Margherita",
      "tipo": "Prato Principal",
      "ingredientes": ["massa de pizza", "molho de tomate", "muçarela", "manjericão"],
      "preco": 22.99
    },
    {
      "nome": "Hambúrguer Artesanal",
      "tipo": "Prato Principal",
      "ingredientes": ["pão de hambúrguer", "carne bovina", "alface", "tomate", "maionese"],
      "preco": 14.50
    },
    {
      "nome": "Salmão Grelhado",
      "tipo": "Prato Principal",
      "ingredientes": ["salmão", "arroz selvagem", "aspargos"],
      "preco": 24.99
    },
    {
      "nome": "Tiramisu",
      "tipo": "Sobremesa",
      "ingredientes": ["biscoitos champagne", "café", "mascarpone", "cacau em pó"],
      "preco": 9.99
    },
    {
      "nome": "Sorvete de Chocolate",
      "tipo": "Sobremesa",
      "ingredientes": ["leite", "chocolate", "açúcar"],
      "preco": 6.50
    },
    {
      "nome": "Bife à Parmegiana",
      "tipo": "Prato Principal",
      "ingredientes": ["bife de carne", "molho de tomate", "queijo", "farinha de rosca"],
      "preco": 19.99
    }
  ];

  // Função para comprar um item
  void _comprarItem(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompraScreen(
          item: item,
          onConfirmarCompra: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${item["nome"]} comprado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          onCancelarCompra: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Compra de ${item["nome"]} foi cancelada.'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio do Dia'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cardapios.length,
        itemBuilder: (context, index) {
          final item = cardapios[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: const Icon(Icons.fastfood, color: Colors.white),
              ),
              title: Text(
                item['nome'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Preço: R\$${item['preco'].toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                onPressed: () => _comprarItem(item),
                child: const Text('Comprar'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CompraScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onConfirmarCompra;
  final VoidCallback onCancelarCompra;

  const CompraScreen({
    super.key,
    required this.item,
    required this.onConfirmarCompra,
    required this.onCancelarCompra,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compra: ${item['nome']}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Você está comprando:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              item['nome'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 16),
            Text(
              'Preço: R\$${item['preco'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredientes: ${item['ingredientes'].join(', ')}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    onCancelarCompra();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    onConfirmarCompra();
                    Navigator.pop(context);
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
