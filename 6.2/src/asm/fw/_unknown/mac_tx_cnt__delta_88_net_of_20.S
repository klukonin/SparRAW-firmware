/* mac_tx_cnt__delta_88_net_of_20 @ 0x8dd768, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring, sm_pring__slot_optimized, ts_ring__time_delta_b_thunk
 * Глобалы (через gp): 0x8002dc, 0x8003d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_tx_cnt__delta_88_net_of_20
mac_tx_cnt__delta_88_net_of_20:
	.global L_8dd768
L_8dd768:
	ld.as r2,[gp,0x94]
L_8dd76c:
	ld_s r0,[gp,0x158]
L_8dd76e:
	ld r1,[r2, 0x88]
L_8dd772:
	sub_s r1,r1,r0
L_8dd774:
	ld_s r0,[r2,0x20]
L_8dd776:
	j_s.d [blink]
L_8dd778:
	rsub r0,r0,r1
