/* lmac_if__ucode_init @ 0x8f5fd8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Initializing uCode interface
 *   Reseting the uCode
 *   Unmask the uCode interrupts
 * Зовут его: fw_main
 * Зовёт сам: fw_log_emit0, fw_sysassert_fatal, lmac_if__build_cmd_rings
 * Глобалы (через gp): 0x8003c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__ucode_init
lmac_if__ucode_init:
	.global L_8f5fd8
L_8f5fd8:
	push_s blink
L_8f5fda:
	mov_s r1,0x1004868
L_8f5fe0:
	bl.d L_8dcba8
L_8f5fe4:
	mov_s r0,0x20
L_8f5fe6:
	ld_s r0,[gp,0x244]
L_8f5fe8:
	brne_s r0,0,L_8f602e
	.global L_8f5fea
L_8f5fea:
	mov_s r0,0x804280
L_8f5ff0:
	bl L_8f94e4
L_8f5ff4:
	mov_s r1,0x1004888
L_8f5ffa:
	bl.d L_8dcba8
L_8f5ffe:
	mov_s r0,0x20
L_8f6000:
	mov_s r1,0x31
L_8f6002:
	mov_s r0,0x880180
L_8f6008:
	st_s r1,[r0,0x7c]
L_8f600a:
	sync
L_8f600e:
	mov_s r1,0x100489c
L_8f6014:
	bl.d L_8dcba8
L_8f6018:
	mov_s r0,0x20
L_8f601a:
	mov r1,0x200
L_8f601e:
	mov_s r0,0x880b00
L_8f6024:
	st_s r1,[r0,0x64]
L_8f6026:
	sync
L_8f602a:
	pop_s blink
L_8f602c:
	j_s [blink]
	.global L_8f602e
L_8f602e:
	mov_s r0,blink
L_8f6030:
	mov_s r1,0x45
L_8f6032:
	bl.d L_8c9b28
L_8f6036:
	bset_s r1,r1,0xc
L_8f6038:
	b_s L_8f5fea
L_8f603a:
	nop_s
