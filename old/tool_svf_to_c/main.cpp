#include <QCoreApplication>
#include <QFile>

#define RUNTEST_128_TCK 0
#define RUNTEST_IDLE_128_TCK_ENDSTATE_IDLE 1
#define RUNTEST_8000_TCK 2
#define RUNTEST_25000_TCK 3
#define RUNTEST_8750003_TCK 4
#define SDR_23_TDI 5
#define SDR_32_TDI 6
#define SDR_32_TDI_0_TDO_F_MASK_F 7
#define SDR_32_TDI_0_TDO_F 8
#define SDR_32_TDI_0_TDO 9
#define SDR_32_TDI_0_TDO_MASK 10
#define SDR_1_TDI_0_TDO_1_MASK_1 11
#define SIR_10_TDI 12

int main(int argc, char *argv[])
{
    //QCoreApplication a(argc, argv);

    //return a.exec();

    QFile in_file("wasca.svf");
    in_file.open(QIODevice::ReadOnly);
    QFile out_file("wasca_svf.c");
    out_file.open(QIODevice::WriteOnly);

    //QByteArray baFull = in_file.readAll();
    //in_file.close();

    //QList<QByteArray> baFullList = baFull.split('\r');

    //QList<QByteArray> Strings;
    QList<QByteArray> baFullList;
    QList<unsigned int> Indexes;
    QList<unsigned int> Args1;
    QList<unsigned int> Args2;

    QByteArray ba ;
    QByteArray ba2,ba3;
    QList<QByteArray> _list;

    ba = in_file.readLine();
    int iLine = 0;

    while (ba.size()>0)
    {
        baFullList.append(ba);
        _list = ba.split(' ');
        //parsing special cases
        if (ba.startsWith("RUNTEST 128 TCK;"))
        {
            Indexes.append(RUNTEST_128_TCK);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if  (ba.startsWith("RUNTEST IDLE 128 TCK ENDSTATE IDLE;"))
        {
            Indexes.append(RUNTEST_IDLE_128_TCK_ENDSTATE_IDLE);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if (ba.startsWith("RUNTEST 8000 TCK;"))
        {
            Indexes.append(RUNTEST_8000_TCK);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if (ba.startsWith("RUNTEST 25000 TCK;"))
        {
            Indexes.append(RUNTEST_25000_TCK);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if (ba.startsWith("RUNTEST 8750003 TCK;"))
        {
            Indexes.append(RUNTEST_8750003_TCK);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if ( (ba.startsWith("SDR 23 TDI (")) && (_list.size() == 4) )
        {
            Indexes.append(SDR_23_TDI);
            ba2 = _list.at(3);
            ba2 = ba2.mid(1);
            ba2 = ba2.left(ba2.indexOf(')'));
            Args1.append(ba2.toUInt(nullptr,16));
            if (0xBA840 == (ba2.toUInt(nullptr,16)))
            {
                    volatile int k;
                    k=5;
            }
            //Args2.append(0);
        }
        else if ( (ba.startsWith("SDR 32 TDI (")) && (_list.size() == 4) )
        {
            Indexes.append(SDR_32_TDI);
            ba2 = _list.at(3);
            ba2 = ba2.mid(1);
            ba2 = ba2.left(ba2.indexOf(')'));
            Args1.append(ba2.toUInt(nullptr,16));
            //Args2.append(0);
        }
        else if (ba.startsWith("SDR 32 TDI (00000000) TDO (FFFFFFFF) MASK (FFFFFFFF);"))
        {
            Indexes.append(SDR_32_TDI_0_TDO_F_MASK_F);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if (ba.startsWith("SDR 32 TDI (00000000) TDO (FFFFFFFF);"))
        {
            Indexes.append(SDR_32_TDI_0_TDO_F);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if ( (ba.startsWith("SDR 32 TDI (00000000) TDO (")) && (ba.contains("MASK (")) && (_list.size() == 8) )
        {
            Indexes.append(SDR_32_TDI_0_TDO_MASK);
            ba2 = _list.at(5);
            ba2 = ba2.mid(1);
            ba2 = ba2.left(ba2.indexOf(')'));
            Args1.append(ba2.toUInt(nullptr,16));
            ba2 = _list.at(7);
            ba2 = ba2.mid(1);
            ba2 = ba2.left(ba2.indexOf(')'));
            ba2.prepend("0x");
            Args2.append(ba2.toUInt(nullptr,16));
        }
        else if ( (ba.startsWith("SDR 32 TDI (00000000) TDO (")) && (_list.size() == 6) )
        {
            Indexes.append(SDR_32_TDI_0_TDO);
            ba2 = _list.at(5);
            ba2 = ba2.mid(1);
            ba2 = ba2.left(ba2.indexOf(')'));
            Args1.append(ba2.toUInt(nullptr,16));
            //Args2.append(0);
        }
        else if ( (ba.startsWith("SDR 1 TDI (0) TDO (1) MASK (1);")))
        {
            Indexes.append(SDR_1_TDI_0_TDO_1_MASK_1);
            //Args1.append(0);
            //Args2.append(0);
        }
        else if ( (ba.startsWith("SIR 10 TDI (")) && (_list.size() == 4) )
        {
            Indexes.append(SIR_10_TDI);
            ba2 = _list.at(3);
            ba2 = ba2.mid(1);
            ba2 = ba2.left(ba2.indexOf(')'));
            Args1.append(ba2.toUInt(nullptr,16));
            //Args2.append(0);
        }
        else if ( (ba.startsWith("!")))
        {
            //comment, ignoring
        }
        else if ( (ba.startsWith("TRST ABSENT")))
        {
            //ignoring
        }
        else if ( (ba.startsWith("ENDDR IDLE")))
        {
            //ignoring
        }
        else if ( (ba.startsWith("ENDIR IRPAUSE")))
        {
            //ignoring
        }
        else if ( (ba.startsWith("STATE IDLE")))
        {
            //ignoring
        }
        else if ( (ba.startsWith("FREQUENCY")))
        {
            //ignoring
        }
        else
        {
            printf("ERROR at %i : %s\r\n",iLine,ba.data());

        }

        /*
        if (Strings.contains(ba))
        {
            Indexes.append(Strings.indexOf(ba));

        }
        else
        {
            Strings.append(ba);
            Indexes.append(Strings.size()-1);
        }
        ba = in_file.readLine();
        if (Indexes.size()%10000==0)
            printf("%i\r\n",Indexes.size());
            */
        ba = in_file.readLine();
        iLine++;
    }

    out_file.write("#include \"wasca_svf.h\"\r\n");

    //writing indexes first
    out_file.write(QString("const unsigned char cmdlist[%1] = {\r\n").arg(Indexes.size()).toLatin1());
    for (int i=0;i<Indexes.size();i++)
    {
        out_file.write(QString("%1,").arg(Indexes.at(i)).toLatin1());
        /*switch(Indexes.at(i))
        {
            case
        }*/

        if (i%16==15)
            out_file.write("\r\n");
    }
    out_file.write("};\r\n");

    out_file.write(QString("const unsigned int args1_list[%1] = {\r\n").arg(Args1.size()).toLatin1());
    for (int i=0;i<Args1.size();i++)
    {
        out_file.write(QString("0x%1,").arg(Args1.at(i),0,16).toLatin1());

        if (i%16==15)
            out_file.write("\r\n");
    }
    out_file.write("};\r\n");

    out_file.write(QString("const unsigned int args2_list[%1] = {\r\n").arg(Args2.size()).toLatin1());
    for (int i=0;i<Args2.size();i++)
    {
        out_file.write(QString("0x%1,").arg(Args2.at(i),0,16).toLatin1());

        if (i%16==15)
            out_file.write("\r\n");
    }
    out_file.write("};\r\n");


    //now funcs
    /*out_file.write(QString("const struct CMD_ARGS cmdargs[%1] = {\r\n").arg(Strings.size()).toLatin1());
    for (int i=0;i<Strings.size();i++)
    {
        ba=Strings.at(i);
        if (ba.startsWith("SIR"))
        {
            out_file.write("{");
            _list = ba.split(' ');
            //out_file.write(QString("__do_SIR_%1(").arg(_list.size()-1).toLatin1());
            out_file.write(QString("__cmd_SIR_%1,").arg(_list.size()-1).toLatin1());
            for (int i=1;i<_list.size()-1;i++)
            {
                ba2 = _list.at(i);
                ba2.replace("(","0x");
                ba2.replace(")","");
                out_file.write(ba2);
                out_file.write(", ");
            }
            ba2 = _list.at(_list.size()-1);
            ba2=ba2.left(ba2.indexOf(";"));
            ba2.replace("(","0x");
            ba2.replace(")","");
            out_file.write(ba2);
            //out_file.write(");\r\n");
            //out_file.write(",\r\n");
            out_file.write("},\r\n");
        }
        else if (ba.startsWith("SDR"))
        {
            out_file.write("{");
            _list = ba.split(' ');
            //out_file.write(QString("__do_SDR_%1(").arg(_list.size()-1).toLatin1());
            out_file.write(QString("__cmd_SDR_%1,").arg(_list.size()-1).toLatin1());
            for (int i=1;i<_list.size()-1;i++)
            {
                ba2 = _list.at(i);
                ba2.replace("(","0x");
                ba2.replace(")","");
                out_file.write(ba2);
                out_file.write(", ");
            }
            ba2 = _list.at(_list.size()-1);
            ba2=ba2.left(ba2.indexOf(";"));
            ba2.replace("(","0x");
            ba2.replace(")","");
            out_file.write(ba2);
            //out_file.write(");\r\n");
            //out_file.write(",\r\n");
            out_file.write("},\r\n");
        }
        else if (ba.startsWith("RUNTEST"))
        {
            out_file.write("{");
            _list = ba.split(' ');
            //out_file.write(QString("__do_RUNTEST_%1(").arg(_list.size()-1).toLatin1());
            out_file.write(QString("__cmd_RUNTEST_%1,").arg(_list.size()-1).toLatin1());
            for (int i=1;i<_list.size()-1;i++)
            {
                ba2 = _list.at(i);
                ba2.replace("(","0x");
                ba2.replace(")","");
                out_file.write(ba2);
                out_file.write(", ");
            }
            ba2 = _list.at(_list.size()-1);
            ba2=ba2.left(ba2.indexOf(";"));
            ba2.replace("(","0x");
            ba2.replace(")","");
            out_file.write(ba2);
            //out_file.write(");\r\n");
            //out_file.write(",\r\n");
            out_file.write("},\r\n");
        }
        else
        {
            out_file.write("//");
            out_file.write(ba);
        }
        //ba.clear();
        //ba = in_file.readLine();
    }

    out_file.write("};\r\n");*/

    in_file.close();
    out_file.close();

    printf("Finished\r\n",Indexes.size());
}
