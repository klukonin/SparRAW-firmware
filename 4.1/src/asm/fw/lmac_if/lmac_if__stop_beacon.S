/* lmac_if__stop_beacon @ 0x8d815c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_bcon__del_bcon
 * Зовёт сам: basic_if__alloc_mbox_slot, lmac_if__mark_stop_beacon, send_cmd2_lmac
 */
	.section .text.lmac_if__stop_beacon,"ax",@progbits
	.global lmac_if__stop_beacon
lmac_if__stop_beacon:
	.global L_8d815c
L_8d815c:
	push_s blink
L_8d815e:
	mov_s r0,0x803e3c
L_8d8164:
	bl L_8c2c38
L_8d8168:
	mov.f r2,r0
L_8d816c:
	beq_s L_8d8184
L_8d816e:
	mov_s r0,0x0
L_8d8170:
	st_s r0,[r2,0x74]
L_8d8172:
	bl.d L_8d8154
L_8d8176:
	mov_s r0,r2
L_8d8178:
	mov_s r0,r2
L_8d817a:
	mov_s r1,0xb
L_8d817c:
	mov_s r2,0x94
L_8d817e:
	bl.d L_8e0694
L_8d8182:
	mov_s r3,0x0
	.global L_8d8184
L_8d8184:
	pop_s blink
L_8d8186:
	j_s [blink]
