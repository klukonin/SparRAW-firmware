/* instruction_error__report @ 0x8c3ad4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Bad instruction (attempt to access ICCM).
 *   Reason: ST/LD cmd before [ilink2=0x%X] (address being accessed is 0x%X)
 *   If the above address is not us - check [blink=0x%X]
 *   Bad instruction (unknown action point %X)
 *   Bad instruction (unknown reason)
 * Зовут его: isr_instruction_error
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, arc__debug_cause, arc__read_aux_by_index, fw_log__emit0, fw_log__emit1, fw_log__emit2
 */
	.section .text.instruction_error__report,"ax",@progbits
	.global instruction_error__report
instruction_error__report:
	.global L_8c3ad4
L_8c3ad4:
	push_s blink
L_8c3ad6:
	bl L_8c02c0
L_8c3ada:
	mov_s r15,r0
L_8c3adc:
	bl.d L_8e96d0
L_8c3ae0:
	mov_s r14,r1
L_8c3ae2:
	mov.f r3,r0
L_8c3ae6:
	beq_s L_8c3b36
L_8c3ae8:
	bbit0 r3,0x1,L_8c3b26
L_8c3aec:
	bl.d L_8e96dc
L_8c3af0:
	mov_s r0,0x1
L_8c3af2:
	mov_s r13,r0
L_8c3af4:
	mov_s r2,0x10000a0
L_8c3afa:
	mov_s r0,0x0
L_8c3afc:
	bl.d L_8edfb0
L_8c3b00:
	mov_s r1,r0
L_8c3b02:
	mov_s r2,0x10000cc
L_8c3b08:
	mov_s r0,0x0
L_8c3b0a:
	mov_s r1,r0
L_8c3b0c:
	mov_s r3,r14
L_8c3b0e:
	bl.d L_8edff8
L_8c3b12:
	mov_s r4,r13
L_8c3b14:
	mov_s r2,0x1000114
L_8c3b1a:
	mov_s r0,0x0
L_8c3b1c:
	mov_s r1,r0
L_8c3b1e:
	bl.d L_8edfcc
L_8c3b22:
	mov_s r3,r15
L_8c3b24:
	b_s L_8c3b44
	.global L_8c3b26
L_8c3b26:
	mov_s r2,0x1000148
L_8c3b2c:
	mov_s r0,0x0
L_8c3b2e:
	bl.d L_8edfcc
L_8c3b32:
	mov_s r1,r0
L_8c3b34:
	b_s L_8c3b44
	.global L_8c3b36
L_8c3b36:
	mov_s r2,0x1000174
L_8c3b3c:
	mov_s r0,0x0
L_8c3b3e:
	bl.d L_8edfb0
L_8c3b42:
	mov_s r1,r0
	.global L_8c3b44
L_8c3b44:
	b L_8c032c
