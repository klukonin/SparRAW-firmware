/* init_bcast_queue @ 0x8d973c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   init_bcast_queue: supported bcast MTU is %d which is less than %d
 * Зовут его: wmi_bcast_vring_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, tx_macq__config_ring_params, tx_macq__setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global init_bcast_queue
init_bcast_queue:
	.global L_8d973c
L_8d973c:
	push_s blink
L_8d973e:
	bl.d L_8c01dc
L_8d9742:
	mov_s r2,0x10
L_8d9744:
	mov_s r14,r0
L_8d9746:
	mov r16,0xfb0
L_8d974e:
	asl_s r13,r1,0x4
L_8d9750:
	add_s r13,r13,0x806014
L_8d9756:
	stb_s r1,[r13,0xa]
L_8d9758:
	stw_s r0,[r13,0x6]
L_8d975a:
	mov_s r15,0x0
L_8d975c:
	stb_s r15,[r13,0xc]
L_8d975e:
	mov_s r0,r13
L_8d9760:
	mov_s r1,0x40
L_8d9762:
	mov_s r3,0x9
L_8d9764:
	asl_s r3,r3,0xb
L_8d9766:
	mov r4,0x800
L_8d976e:
	bl.d L_8e29b8
L_8d9772:
	mov r5,r16
L_8d9776:
	mov_s r0,r13
L_8d9778:
	mov_s r1,0x7
L_8d977a:
	mov_s r2,r15
L_8d977c:
	mov_s r3,r15
L_8d977e:
	mov_s r4,r15
L_8d9780:
	mov_s r5,r15
L_8d9782:
	mov_s r6,r15
L_8d9784:
	bl.d L_8d944c
L_8d9788:
	mov_s r7,r15
L_8d978a:
	brge r16,r14,L_8d979e
L_8d978e:
	mov_s r1,0x1018d20
L_8d9794:
	mov_s r0,0x10
L_8d9796:
	mov_s r2,r16
L_8d9798:
	bl.d L_8dcc80
L_8d979c:
	mov_s r3,r14
	.global L_8d979e
L_8d979e:
	b L_8c0244
L_8d97a2:
	nop_s
