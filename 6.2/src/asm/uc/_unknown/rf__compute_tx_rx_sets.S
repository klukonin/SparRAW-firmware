/* rf__compute_tx_rx_sets @ 0x92102c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__compute_tx_rx_sets
rf__compute_tx_rx_sets:
	.global L_92102c
L_92102c:
	push_s blink
L_92102e:
	bl L_920234
L_921032:
	mov_s r14,0x0
L_921034:
	mov_s r13,r14
L_921036:
	mov_s r1,r14
L_921038:
	b_s L_92104c
	.global L_92103a
L_92103a:
	add_s r0,r2,r1
L_92103c:
	ldb r0,[r0, -0x5c]
L_921040:
	add_s r2,r2,r1
L_921042:
	or_s r14,r14,r0
L_921044:
	ldb r0,[r2, -0x74]
L_921048:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92104a:
	or_s r13,r13,r0
	.global L_92104c
L_92104c:
	mov_s r2,0x857800
L_921052:
	ld r0,[r2, -0x98]
L_921056:
	brlo r1,r0,L_92103a
L_92105a:
	breq_s r14,0,L_921086
	.global L_92105c
L_92105c:
	breq_s r13,0,L_921092
	.global L_92105e
L_92105e:
	mov_s r2,0x0
L_921060:
	mov_s r1,0x802940
L_921066:
	mov_s r0,0xcc
L_921068:
	tst_s r14,r0
L_92106a:
	st_s r2,[r1]
L_92106c:
	st_s r2,[r1,0x4]
L_92106e:
	beq_s L_921074
L_921070:
	mov_s r2,0x1
L_921072:
	st_s r2,[r1]
	.global L_921074
L_921074:
	bic.f r14,r14,-0x34
L_921078:
	beq_s L_92107e
L_92107a:
	bset_s r2,r2,0x1
L_92107c:
	st_s r2,[r1]
	.global L_92107e
L_92107e:
	tst_s r13,r0
L_921080:
	bne_s L_92109e
L_921082:
	mov_s r0,0x0
L_921084:
	b_s L_9210a2
	.global L_921086
L_921086:
	mov_s r0,blink
L_921088:
	bl.d L_926618
L_92108c:
	mov r1,0x10b
L_921090:
	b_s L_92105c
	.global L_921092
L_921092:
	mov_s r0,blink
L_921094:
	bl.d L_926618
L_921098:
	mov r1,0x10c
L_92109c:
	b_s L_92105e
	.global L_92109e
L_92109e:
	mov_s r0,0x1
L_9210a0:
	st_s r0,[r1,0x4]
	.global L_9210a2
L_9210a2:
	bic.f r13,r13,-0x34
L_9210a6:
	beq_s L_9210ac
L_9210a8:
	bset_s r0,r0,0x1
L_9210aa:
	st_s r0,[r1,0x4]
	.global L_9210ac
L_9210ac:
	b L_9202a4
