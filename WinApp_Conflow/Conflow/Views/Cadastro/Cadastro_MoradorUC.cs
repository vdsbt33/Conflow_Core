﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace Conflow
{
    /*
    Classe: Cadastro_MoradorUC
    Descrição: Contém os métodos do user control Cadastro_MoradorUC.
    */
    public partial class Cadastro_MoradorUC : UserControl
    {
        /*
        Construtor: Cadastro_MoradorUC()
        Descrição: -.
        */
        public Cadastro_MoradorUC()
        {
            InitializeComponent();
        }

        AtalhosSQL ComandosSQL = new AtalhosSQL();

        /*
        Função: CriarBtn_Click(object sender, EventArgs e)
        Descrição: Adiciona o Morador ao Banco de Dados.
        */
        private void CriarBtn_Click(object sender, EventArgs e)
        {
            DataGridViewSelectedRowCollection linhaSelecionada = apartamentoList.SelectedRows;
            if (nomeTbox.Text.Length > 0 && predioList.SelectedRows[0] != null && predioList.SelectedRows.Count > 0 && apartamentoList.SelectedRows.Count > 0)
            {
                

                String dataNascimento = datanascimentoDtp.Value.Date.Year.ToString();
                dataNascimento += ComandosSQL.ConverterDataHora(datanascimentoDtp.Value.Date.Month.ToString());
                dataNascimento += ComandosSQL.ConverterDataHora(datanascimentoDtp.Value.Date.Day.ToString());


                // Criando Morador
                String cmdTxt = "";
                String timestamp_criacao = ComandosSQL.current_timestamp;
                cmdTxt = "INSERT INTO MORADOR(          " +
                         "    NOME_MORADOR,             " +
                         "    SEXO_MORADOR,             " +
                         "    DAT_NASCIMENTO_MORADOR,    " +
                         "    COD_APARTAMENTO_MORADOR,  " +
                         "    ULTIMA_MODIFICACAO             " +
                         ") VALUES(                          " +
                         "    @nome                          " +
                         "   ,@sexo                          " +
                         "   ,@dat_nasc                      " +
                         "   ,@cod_apartamento               " +
                         "   ,@timestamp_criacao             " +
                         ");                                 ";
                ComandosSQL.comandoSql.Parameters.AddWithValue("nome", nomeTbox.Text);
                if (sexoMRBtn.Checked)
                {
                    ComandosSQL.comandoSql.Parameters.AddWithValue("sexo", "M");
                }
                else
                {
                    ComandosSQL.comandoSql.Parameters.AddWithValue("sexo", "F");
                }
                ComandosSQL.comandoSql.Parameters.AddWithValue("dat_nasc", dataNascimento);
                ComandosSQL.comandoSql.Parameters.AddWithValue("cod_apartamento", linhaSelecionada[0].Cells["COD_APARTAMENTO"].Value);
                ComandosSQL.comandoSql.Parameters.AddWithValue("timestamp_criacao", timestamp_criacao);

                // Limpa os campos
                nomeTbox.Clear();
                sexoMRBtn.Checked = true;
                datanascimentoDtp.Value = DateTime.Today;
                AtualizarLocalizacao();
                ComandosSQL.ExecutarComandoSql(cmdTxt, "Morador adicionado com sucesso!", "Ocorreu um problema e o morador não pôde ser adicionado. \n\nDescrição");
                
            }
            else
            {
                MessageBox.Show("Erro: Um ou mais campos não foram preenchidos.");
            }
        }

        /*
        Função: AtualizarLocalizacao()
        Descrição: Atualiza as listas do grupo Localização.
        */
        public void AtualizarLocalizacao()
        {
            try
            {
                nomeTbox.Focus();

                ComandosSQL.conn = new MySqlConnection(AtalhosSQL.str);
                ComandosSQL.conn.Open();

                // Limpando listas
                condominioList.Rows.Clear();
                predioList.Rows.Clear();
                apartamentoList.Rows.Clear();

                String cmdSelect = "SELECT COD_CONDOMINIO, ID_CONDOMINIO " +
                                    "FROM CONDOMINIO;";

                MySqlCommand cmd = new MySqlCommand(cmdSelect, ComandosSQL.conn);
                cmd.Prepare();
                using (MySqlDataReader leitor = cmd.ExecuteReader())
                {
                    while (leitor.Read())
                    {
                        int index = condominioList.Rows.Add();
                        DataGridViewRow linhaTabela = condominioList.Rows[index];
                        linhaTabela.Cells["COD_CONDOMINIO"].Value = Convert.ToInt32(leitor["COD_CONDOMINIO"]);
                        linhaTabela.Cells["ID_CONDOMINIO"].Value = leitor["ID_CONDOMINIO"];
                    }
                }

            }
            catch (Exception excessao)
            {
                MessageBox.Show("Um erro ocorreu ao tentar ler o banco de dados. \nDescrição: " + excessao.Message);
            }

            ComandosSQL.conn.Close();
        }

        /*
        Função: condominioList_RowEnter()
        Descrição: Atualiza a lista de Prédios ao trocar o Condomínio selectionado.
        */
        private void condominioList_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (condominioList.SelectedRows.Count > 0)
            {

                try
                {
                    ComandosSQL.conn = new MySqlConnection(AtalhosSQL.str);
                    ComandosSQL.conn.Open();

                    // Limpando listas
                    predioList.Rows.Clear();
                    apartamentoList.Rows.Clear();

                    String cmdSelect = "SELECT PRE.COD_PREDIO, PRE.ID_PREDIO " +
                                       "FROM PREDIO PRE " +
                                       "LEFT JOIN BLOCO BLO ON PRE.COD_BLOCO = BLO.COD_BLOCO " +
                                       "LEFT JOIN CONDOMINIO CON ON BLO.COD_CONDOMINIO = CON.COD_CONDOMINIO " +
                                       "WHERE CON.COD_CONDOMINIO = @cod;";

                    MySqlCommand cmd = new MySqlCommand(cmdSelect, ComandosSQL.conn);

                    DataGridViewSelectedRowCollection linhaSelecionada = condominioList.SelectedRows;

                    cmd.Parameters.AddWithValue("cod", Convert.ToInt32(linhaSelecionada[0].Cells["COD_CONDOMINIO"].Value));


                    cmd.Prepare();
                    using (MySqlDataReader leitor = cmd.ExecuteReader())
                    {
                        while (leitor.Read())
                        {

                            int index = predioList.Rows.Add();
                            DataGridViewRow linhaTabela = predioList.Rows[index];
                            linhaTabela.Cells["COD_PREDIO"].Value = Convert.ToInt32(leitor["COD_PREDIO"]);
                            linhaTabela.Cells["ID_PREDIO"].Value = Convert.ToString(leitor["ID_PREDIO"]);
                        }
                    }

                }
                catch (Exception excessao)
                {
                    MessageBox.Show("Um erro ocorreu ao tentar ler o banco de dados. \nDescrição: " + excessao.Message);
                }

                ComandosSQL.conn.Close();
            }

        }

        /*
        Função: predioList_RowEnter(object sender, DataGridViewCellEventArgs e)
        Descrição: Atualiza a lista de Prédios.
        */
        private void predioList_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (predioList.SelectedRows.Count > 0)
            {

                try
                {
                    ComandosSQL.conn = new MySqlConnection(AtalhosSQL.str);
                    ComandosSQL.conn.Open();

                    // Apartamentos
                    apartamentoList.Rows.Clear();

                    String cmdSelect = "SELECT COD_APARTAMENTO, NUM_APARTAMENTO " +
                                        "FROM APARTAMENTO " +
                                        "WHERE COD_PREDIO = @cod;";

                    MySqlCommand cmd = new MySqlCommand(cmdSelect, ComandosSQL.conn);

                    DataGridViewSelectedRowCollection linhaSelecionada = predioList.SelectedRows;

                    cmd.Parameters.AddWithValue("cod", Convert.ToInt32(linhaSelecionada[0].Cells["COD_PREDIO"].Value));


                    cmd.Prepare();
                    using (MySqlDataReader leitor = cmd.ExecuteReader())
                    {
                        while (leitor.Read())
                        {

                            int index = apartamentoList.Rows.Add();
                            DataGridViewRow linhaTabela = apartamentoList.Rows[index];
                            linhaTabela.Cells["COD_APARTAMENTO"].Value = Convert.ToInt32(leitor["COD_APARTAMENTO"]);
                            linhaTabela.Cells["NUM_APARTAMENTO"].Value = Convert.ToInt32(leitor["NUM_APARTAMENTO"]);
                        }
                    }

                }
                catch (Exception excessao)
                {
                    MessageBox.Show("Um erro ocorreu ao tentar ler o banco de dados. \nDescrição: " + excessao.Message);
                }

                ComandosSQL.conn.Close();
            }

        }
    }
}
