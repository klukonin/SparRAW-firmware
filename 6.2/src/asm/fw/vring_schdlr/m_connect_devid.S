/* m_connect_devid @ 0x8c9024, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_NONASSOC_SM__ps_reenter_done
 * Зовёт сам: PS_CONNECTION__disassoc_ntf
 * Глобалы (через gp): 0x800274
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global m_connect_devid
m_connect_devid:
	.global L_8c9024
L_8c9024:
	push_s blink
L_8c9026:
	mov_s r2,0x0
L_8c9028:
	ld.as r1,[gp,0x3c]
L_8c902c:
	bset r2,r2,r0
L_8c9030:
	tst_s r1,r2
L_8c9032:
	beq_s L_8c904a
L_8c9034:
	mul64 r0,0x88
L_8c9038:
	bic_s r1,r1,r2
L_8c903a:
	add r0,mlo,0x803db0
L_8c9042:
	bl.d L_8c8ff0
L_8c9046:
	st.as r1,[gp,0x3c]
	.global L_8c904a
L_8c904a:
	pop_s blink
L_8c904c:
	j_s [blink]
L_8c904e:
	nop_s
