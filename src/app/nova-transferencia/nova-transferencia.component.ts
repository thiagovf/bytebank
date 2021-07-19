import { Component, EventEmitter, Output } from "@angular/core";
import { Transferencia } from "../models/transferencia.model";
import { TransferenciaService } from "../services/transferencia.service";

@Component ({
    selector: 'app-nova-transferencia',
    templateUrl: './nova-transferencia.component.html',
    styleUrls: ['./nova-transferencia.component.scss']
})
export class NovaTransferenciaComponent {

    valor!: number;
    destino!: number;

    constructor(private transferenciaService: TransferenciaService) {

    }

    transferir(): void {
        const transferencia: Transferencia = {valor: this.valor, destino: this.destino};
        this.transferenciaService.adicionar(transferencia).subscribe(resultado => {
            console.log(resultado);
            this.limparValor();
        }, error => console.error(error));
    }

    limparValor(): void {
        this.valor = 0;
        this.destino = 0;
    }
}